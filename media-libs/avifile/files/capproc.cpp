#include "capproc.h"
#include "dsp.h"
#include <unistd.h>
#include <avifile.h>
#include <videoencoder.h>
#include <aviutil.h>

#define __MODULE__ "Capture Process"
class frame_allocator
{
    struct frame
    {
	char* data;
	int status;
    };
    int _w; 
    int _h;
    vector<frame> frames;
    int _limit;
    int refs;
public:
    frame_allocator(int w, int h, int limit):_w(w), _h(h), _limit(limit),refs(2){}
    void release()
    {
	refs--;
	if(!refs)delete this;
    }	
    char* alloc()
    {
	int i;
	for(i=0; i<frames.size(); i++)
	{
	    if(frames[i].status==0)
	    {
		frames[i].status=1;
		*(int*)(frames[i].data)=i;
		return frames[i].data+4;
	    }	
	}
	if(frames.size()>=_limit)return 0;
	frame f;
	f.data=new char[_w*_h*3+4];
	f.status=1;
	frames.push_back(f);
	*(int*)(f.data)=i;
	return f.data+4;
    }
    void free(char* mem)
    {
	if(!mem)
	{
	    cerr<<"ERROR: Freeing 0!"<<endl;
	    return;
	}
	int id=*(int*)(mem-4);
	if((id<0)||(id>=frames.size())||(frames[id].data!=(mem-4)))
	{
	    cerr<<"ERROR: Freeing unknown memory!"<<endl;
	    return;
	}
	if(frames[id].status==0)
	{
	    cerr<<"ERROR: Duplicate free()!"<<endl;
	    return;
	}
	frames[id].status=0;
    }    
    ~frame_allocator()
    {
	for(int i=0; i<frames.size(); i++)
	    delete frames[i].data;
    }
};
static frame_allocator* allocator2=0;
void* CaptureProcess::vidcap(void* arg)
{
    CaptureProcess& a=*(CaptureProcess*)arg;
    int w=a.res_w;
    int h=a.res_h;
    const float fps=a.fps;
//    char tmpframe[384*288*4];
    a.m_v4l->grabSetParams(1, &w, &h, VIDEO_PALETTE_RGB24);
    long long& inittime=a.starttime;
    int& cnt=a.cnt;
    int& drop=a.cap_drop;
    cnt=0;
    drop=0;
    allocator2=new frame_allocator(w,h,50);
    while(!a.m_quit)
    {
	int t1,t2,t3;
	long long currenttime=longcount();
	char* z=0;
//	cerr<<currenttime<<" "<<inittime<<" "<<fps<<endl;
//	cerr<<to_float(currenttime, inittime)*fps<<" "<<cnt<<endl;
//	double freq=550000.;
	double dist=double(currenttime-inittime)/(freq*1000.);
//	double dist=to_float(currenttime, inittime);
//	cerr<<dist<<" "<<freq<<endl;
	if(dist*fps<cnt)
	{
	    usleep(10000);
//	    cerr<<"Sleeping"<<endl;
	    continue;
	}    
	chunk ch;
	if(dist*fps<(cnt+1))
	{
	    z=a.m_v4l->grabCapture(false);
//	    char* tmpframe=new char[w*h*3];
	    char* tmpframe=allocator2->alloc();
	    int bpl=3*w;
	    if(tmpframe)
		for(int i=0; i<h; i++)
		    memcpy(tmpframe+i*bpl, z+(h-i-1)*bpl, bpl);
	    ch.data=tmpframe;
	}
	else 
	{
	    ch.data=0;
	    drop++;
	} 
	ch.timestamp=dist;
        a.m_vidq.push(ch);
	cnt++;
//	if(cnt%100==0)
//	    cerr<<"Capture thread: read "<<cnt<<" frames, dropped "<<drop<<" frames"<<endl;
    }
    allocator2->release();
    cerr<<"Capture thread exiting"<<endl;
    return 0;
}
int audioblock=0;
void* CaptureProcess::audcap(void* arg)
{
    CaptureProcess& a=*(CaptureProcess*)arg;
    dsp* thedsp=new dsp();
    if(thedsp->open(a.samplesize,a.chan,a.frequency)==0)//returns file descriptor
	return 0;
    float abps=a.samplesize*a.chan*a.frequency/8;
    char* buf=0;
    int bufsize=0;
    int blocksize=thedsp->getBufSize();
    audioblock=blocksize;
    int tim=0;
    while(!a.m_quit)
    {
//	if(buf==0)
//	{
//	    buf=new char[audioblock];
//	    bufsize=0;
//	}
	buf=new char[audioblock];
	memcpy(buf, thedsp->readBuf(), audioblock);
	long long ct=longcount();
	chunk ch;
	ch.data=buf;
//	double freq=550000.;
	if(a.starttime)
	    ch.timestamp=double(ct-a.starttime)/(freq*1000.);
//	    ch.timestamp=to_float(ct, a.starttime);
	else
	    ch.timestamp=-1;
	a.m_audq.push(ch);
	bufsize+=blocksize;
	tim++;
//	if(tim%50==0)
//	    cerr<<"Audio thread: read "<<float(tim*blocksize)/88200.<<" seconds"<<endl;
	if(blocksize/abps>.1)
	    usleep(50000);
//	if(bufsize==audioblock)
//	{
//	    a.m_audq.push(buf);
//	    buf=0;
//	}
    }
//    if(buf)delete buf;
    delete thedsp;
    return 0;
}
void* CaptureProcess::writer(void* arg)
{
    CaptureProcess& a=*(CaptureProcess*)arg;
    IAviWriteFile* file=0;
    IAviSegWriteFile* sfile=0;    
    IVideoEncoder::SetExtendedAttr(fccIV50, "QuickCompress", 1);
    IAviVideoWriteStream* stream;
    IAviWriteStream* audioStream=0;
    BITMAPINFOHEADER bh;
    
    const double fps=a.fps;
    if(fps==0)
	throw FATAL("FPS = 0 !");
//    VideoEncoder ve;
    try
    {
	if(a.segment_size==-1)
	    file=CreateIAviWriteFile(a.filename.c_str());
	else
	{
    	    sfile=CreateSegmentedFile(a.filename.c_str(), a.segment_size*1024LL);
	    file=sfile;
	}    
//	FILE* zz=fopen("bin/uncompr.bmp", "rb");
	memset(&bh, 0, sizeof(bh));
        bh.biSize=sizeof(bh);
	bh.biWidth=384;
        bh.biHeight=288;
	bh.biBitCount=24;
	bh.biSizeImage=3*384*288;
	bh.biPlanes=1;
	stream=file->AddVideoStream(a.compressor, &bh, 1000000./a.fps);
//	stream=file->AddStream(AviStream::Video);
//	ve.Init(fccIV50, (const char*)&bh);
    }
    catch(FatalError& e)
    {
	e.Print();
	a.m_quit=1;
	return 0;
    }    
    
    float abps=(a.samplesize*a.frequency*a.chan)/8;

    WAVEFORMATEX wfm;
    wfm.wFormatTag=1;//PCM
    wfm.nChannels=a.chan;
    wfm.nSamplesPerSec=a.frequency*a.chan;
    wfm.nAvgBytesPerSec=(int)abps;
    wfm.nBlockAlign=(a.samplesize*a.chan)/8;
    wfm.wBitsPerSample=a.samplesize;
    wfm.cbSize=0;

    
//    ve.SetQuality(9500);
//    ve.Start();
    stream->SetQuality(a.quality);
    stream->Start();
    cerr<<"Entering loop"<<endl;
//    BITMAPINFOHEADER obh=ve.QueryOutputFormat();
//    stream->SetFormat((const char*)&obh, sizeof obh);
    int cnt=0;
    int& drop=a.comp_drop;
    long long audiodata=0LL;
    int videodata=0;
    double video_error=0;
    int hide_video=0;
    int dup_video=0;
    double snd_time, vid_time;
    drop=0;
    
    while(1)
    {
        char qq[384*288*4];
	int x1, x2;
//	char* z;
	chunk ch;
	while(a.m_vidq.size()>50)
	{
	    ch=a.m_vidq.front();
	    a.m_vidq.pop();
	    vid_time=ch.timestamp;
	    cnt++;
	    if(ch.data)//delete ch.data;
		allocator2->free(ch.data);
	    stream->AddFrame(0);
	    videodata++;
//	    stream->AddChunk(0, 0, AVIIF_KEYFRAME);    
	    drop++;
	}
	while((a.m_vidq.size()==0) && (a.m_audq.size()==0))
	{
	    if(a.m_quit) goto finish;
	    usleep(10000);
	}    
	if(a.m_vidq.size())
	{
	    ch=a.m_vidq.front();
	    a.m_vidq.pop();
	    vid_time=ch.timestamp;
	    cnt++;
	    if(!hide_video)
	    {
		videodata++;
		stream->AddFrame(ch.data);
		if(dup_video)
		{
		    videodata++;
		    stream->AddFrame(ch.data);
		    video_error+=1./fps;
		}
	    }
	    else video_error-=1./fps;
	    dup_video=hide_video=0;
    	    if(ch.data)
		allocator2->free(ch.data);
		
	}
	if(a.m_audq.size())
	{
	    if(audioStream==0)
	    {
		audioStream=file->AddStream(AviStream::Audio,
	    	    (const char*)&wfm, 18,
		    1, //uncompressed PCM data
		    abps, //bytes/sec
    		    a.samplesize/8 		//bytes/sample
	        );
	    }	
	    ch=a.m_audq.front();
	    a.m_audq.pop();
//	    cerr<<ch.timestamp-snd_time<<" "<<ch.timestamp-(audiodata+audioblock)/44100./2<<endl;
	    snd_time=ch.timestamp;
	    audioStream->AddChunk(ch.data, audioblock, AVIIF_KEYFRAME);
	    audiodata+=audioblock;
	    double audio_error=audiodata/abps-ch.timestamp;
	    if(audio_error<video_error-5./fps)
		hide_video=1;
	    if(audio_error>video_error+5./fps)
		dup_video=1;
	    delete ch.data;
	}
	if(a.segment_flag && sfile)
	{
	    sfile->Segment();
	    a.segment_flag=0;
//	    vid_clear=aud_clear=0;
    	}	
	if(a.timelimit!=-1)
	{
	    if(snd_time>a.timelimit)
		a.m_quit=1;
	    if(vid_time>a.timelimit)
		a.m_quit=1;
	}
	if(a.sizelimit!=-1)
	{
	    if(file->FileSize()>a.sizelimit*1024LL)
		a.m_quit=1;
	}	
    }
finish:
    long long size=file->FileSize();
    delete file;
    allocator2->release();
    cerr<<"Write thread exiting"<<endl;
    (*a.messenger)<<"Audio: written "<<audiodata<<" bytes ( "<<audiodata/(44100.*2)<<" s )."<<endl;
    (*a.messenger)<<"Video: written "<<videodata<<" frames ( "<<videodata/fps<<" s )."<<endl;
    (*a.messenger)<<"End video pos "<<vid_time<<" s, end audio pos "<<snd_time<<" s."<<endl;
    (*a.messenger)<<"File size: "<<(size/1000)<<" Kb ( "<<size/1000/vid_time<<" Kb/s )."<<endl;
    (*a.messenger)<<"Synch fix: "<<videodata-cnt<<" frames."<<endl;
    (*a.messenger)<<"Frame drop: "<<100.*double(a.cap_drop+drop)/videodata<<"%."<<endl<<flush;
    return 0;
}
void CaptureProcess::Create(v4lxif* v4l,
    string filename,
    int segment_size,		
    int compressor,		
    int quality,		
    int keyframes,		
    enum Sound_Freqs frequency,	
    enum Sample_Sizes samplesize,
    enum Sound_Chans chan,
    enum Resolutions res,
    int timelimit,		
    int sizelimit,
    float fps)
{
    m_v4l=v4l;
    m_quit=0;
    starttime=longcount();
    
    this->filename=filename;
    this->segment_size=segment_size;
    this->compressor=compressor;
    this->quality=quality;
    this->keyframes=keyframes;
    
    switch(frequency)
    {
    case NoAudio:
	break;
    case F44:
	this->frequency=44100;
	break;
    case F22:
	this->frequency=22050;
	break;
    case F11:
	this->frequency=11025;
	break;
    default:
	throw FATAL("Unknown frequency");
    }	
    if(frequency!=NoAudio)
    {
	switch(samplesize)
        {
	case S16:
	    this->samplesize=16;
	    break;
        case S8:
	    this->samplesize=8;
	    break;
	default:
	    throw FATAL("Unknown audio sample size");
	}
	switch(chan)
	{
	case Mono:
	    this->chan=1;
	    break;
	case Stereo:
	    this->chan=2;
	    break;
	default:
	    throw FATAL("Unknown channel number");
	}    
    }    
    switch(res)
    {
    case W384:
	res_w=384;
	res_h=288;
	break;
    case W320:
	res_w=320;
	res_h=240;
	break;
    case W192:
	res_w=192;
	res_h=144;
	break;
    case W160:
	res_w=160;
	res_h=120;
	break;
    default:
	throw FATAL("Unknown video resolution");
    }	
    this->timelimit=timelimit;
    this->sizelimit=sizelimit;
    this->fps=fps;
    pthread_create(&m_vidc, 0, CaptureProcess::vidcap, this);
    if(frequency!=NoAudio)
	pthread_create(&m_audc, 0, CaptureProcess::audcap, this);
    pthread_create(&m_writer, 0, CaptureProcess::writer, this);
}

CaptureProcess::~CaptureProcess()
{
    m_quit=1;
    pthread_join(m_writer,0);
    pthread_join(m_audc,0);
    pthread_join(m_vidc,0);
    cerr<<"All threads exited"<<endl;
//    while(m_vidq.size())
//    {
//	chunk z=m_vidq.front();
//	m_vidq.pop();
//	if(z.data)delete z.data;
//    }	
    while(m_audq.size())
    {
	chunk z=m_audq.front();
	m_audq.pop();
	if(z.data)delete z.data;
    }	
}
