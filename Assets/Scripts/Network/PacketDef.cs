/*
 * File Name: PacketDef.cs
 * Description: Network Packet Defenitions
 * Revisions:
 * ---------------------------------------
 *    Date     Author    Description
 * ---------------------------------------
 * 2016-10-17  tabe      Initial version
 * 
 * 
 */
using System;
using System.Net;


public class AppHeader
{
	public const Int32 MAX_SIZE        = 1024 * 1024;   /// 消息包最大大小
	public const Int32 HEAD_SIZE       = 12;            /// 消息头大小
	public const byte  VER             = 0x01;          /// 版本号
    public const byte  DATA_FMT_JSON   = 0x02;          /// 数据传输格式,默认json
	
    //-----包头组成-----
	public Int32 _pkgLen = 0;                   //包头里第一个字段，4字节
	public byte _ver = VER;                     //包头里第二个字段，1字节
    public byte _needLog = 0x00;                //包头里第二个字段，1字节
    public byte _dataFmt = DATA_FMT_JSON;       //包头里第二个字段，1字节
    public byte _pkgType = 0x00;                //包头里第二个字段，1字节
    public Int32 _id = 0;                       //包头里第二个字段，4字节
	
	public AppHeader ()
	{
	}

	public AppHeader(byte[] buffer)
	{
		int cursor = 0;
        
		Int32 tmpPkgLen = System.BitConverter.ToInt32 (buffer, cursor);
		_pkgLen = System.Net.IPAddress.NetworkToHostOrder (tmpPkgLen);
		cursor += sizeof(UInt32);
		
		_ver = buffer[cursor++];
		_needLog = buffer[cursor++];
		_dataFmt = buffer[cursor++];
		_pkgType = buffer[cursor++];
		
		Int32 tmpId =  System.BitConverter.ToInt32 (buffer, cursor);
		_id = System.Net.IPAddress.NetworkToHostOrder (tmpId);
	}

	public bool IsValid()
	{
		if (_pkgLen > MAX_SIZE || _pkgLen < HEAD_SIZE)
			return false;
		return true;
	}
	
	public void ToBuffer( ref byte[] buffer, ref uint cursor)
	{
		Int32 tmpPkgLen = System.Net.IPAddress.HostToNetworkOrder (_pkgLen);
		byte[] us = System.BitConverter.GetBytes(tmpPkgLen);
		Array.Copy(us, 0, buffer, cursor, sizeof(Int32));
		cursor += sizeof(Int32);
		
		buffer [cursor++] = _ver;
		buffer [cursor++] = _needLog;
		buffer [cursor++] = _dataFmt;
		buffer [cursor++] = _pkgType;

		Int32 tmpId = System.Net.IPAddress.HostToNetworkOrder (_id);
		us = System.BitConverter.GetBytes(tmpId);
		Array.Copy(us, 0, buffer, cursor, sizeof(UInt32));
		cursor += sizeof(Int32);
	}

	public String ToLog()
	{ 
		String log = string.Format("pkgLen:{0:x} ver:{1:x} needLog:{2:x} dataFmt:{3:x} pkgType:{4:x} id:{5:x}", 
		                           _pkgLen, _ver, _needLog, _dataFmt, _pkgType, _id);
		return log;
	}
	
} // class end