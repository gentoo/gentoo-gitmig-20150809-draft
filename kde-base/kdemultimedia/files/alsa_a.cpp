/*

    TiMidity++ -- MIDI to WAVE converter and player
    Copyright (C) 1999 Masanao Izumo <mo@goice.co.jp>
    Copyright (C) 1995 Tuukka Toivonen <tt@cgs.fi>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    linux_audio.c

    Functions to play sound on the VoxWare audio driver (Linux or FreeBSD)

*/

#ifdef AU_ALSA

#ifdef ORIG_TIMPP
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif /* HAVE_CONFIG_H */
#define _GNU_SOURCE
#endif

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#ifndef NO_STRING_H
#include <string.h>
#else
#include <strings.h>
#endif

/*ALSA header file*/
#ifdef __cplusplus
#undef __cplusplus
extern "C" {
#include <sys/asoundlib.h>
}
#define __cplusplus
#else
#include <sys/asoundlib.h>
#endif

#ifdef ORIG_TIMPP
#include "timidity.h"
#else
#include "config.h"
#endif

#include "common.h"
#include "output.h"
#include "controls.h"
/* #include "timer.h" */
#include "instrum.h"
#include "playmidi.h"
/* #include "miditrace.h" */

static int open_output(void); /* 0=success, 1=warning, -1=fatal error */
static void close_output(void);
#ifdef ORIG_TIMPP
static int output_data(char *buf, int32 nbytes);
static int acntl(int request, void *arg);
#else
static void output_data(int32 *buf, uint32 count);
static int driver_output_data(unsigned char *buf, uint32 count);
static void flush_output(void);
static void purge_output(void);
static int output_count(uint32 ct);
#endif
static int total_bytes, output_counter;

/* export the playback mode */

#define dpm alsa_play_mode

#ifdef ORIG_TIMPP
PlayMode dpm = {
  DEFAULT_RATE, PE_16BIT|PE_SIGNED, PF_PCM_STREAM|PF_CAN_TRACE,
  -1,
  {0}, /* default: get all the buffer fragments you can */
  "ALSA pcm device", 's',
  "/dev/snd/pcm00",
  open_output,
  close_output,
  output_data,
  acntl
};
#else
#define PE_ALAW       0x20
PlayMode dpm = {
  DEFAULT_RATE, PE_16BIT|PE_SIGNED,
  -1,
  {0}, /* default: get all the buffer fragments you can */
  "ALSA pcm device", 's',
  "/dev/snd/pcm00",
  open_output,
  close_output,
  output_data,
  driver_output_data,
  flush_output,
  purge_output,
  output_count
};
#endif

/*************************************************************************/
/* We currently only honor the PE_MONO bit, the sample rate, and the
   number of buffer fragments. We try 16-bit signed data first, and
   then 8-bit unsigned if it fails. If you have a sound device that
   can't handle either, let me know. */


/*ALSA PCM handler*/
static snd_pcm_t* handle = NULL;
static int card = 0;
static int device = 0;
static int setup_frags = 0;
static int setup_frag_size = 0;

void alsa_tell(int *fragsize, int *fragstotal)
{
  *fragsize = setup_frag_size;
  *fragstotal = setup_frags;
}

static void error_report (int snd_error)
{
  ctl->cmsg(CMSG_ERROR, VERB_NORMAL, "%s: %s",
	    dpm.name, snd_strerror (snd_error));
}

/*return value == 0 sucess
               == -1 fails
 */
static int check_sound_cards (int* card__, int* device__,
			      const int32 extra_param[5])
{
  /*Search sound cards*/
  struct snd_ctl_hw_info ctl_hw_info;
  snd_pcm_info_t pcm_info;
  snd_ctl_t* ctl_handle;
  const char* env_sound_card = getenv ("TIMIDITY_SOUND_CARD");
  const char* env_pcm_device = getenv ("TIMIDITY_PCM_DEVICE");
  int tmp;

  /*specify card*/
  *card__ = 0;
  if (env_sound_card != NULL)
    *card__ = atoi (env_sound_card);
  /*specify device*/
  *device__ = 0;
  if (env_pcm_device != NULL)
    *device__ = atoi (env_pcm_device);
  
  tmp = snd_cards ();
  if (tmp == 0)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL, "No sound card found.");
      return -1;
    }
  if (tmp < 0)
    {
      error_report (tmp);
      return -1;
    }
  
  if (*card__ < 0 || *card__ >= tmp)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL, "There is %d sound cards."
		" %d is invalid sound card. assuming 0.",
		tmp, *card__);
      *card__ = 0;
    }

  tmp = snd_ctl_open (&ctl_handle, *card__);
  if (tmp != 0)
    {
      error_report (tmp);
      return -1;
    }

  /*check whether sound card has pcm device(s)*/
  tmp = snd_ctl_hw_info (ctl_handle, & ctl_hw_info);
  if (ctl_hw_info.pcmdevs == 0)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL,
		"%d-th sound card(%s) has no pcm device",
		ctl_hw_info.longname, *card__);
      snd_ctl_close (ctl_handle);
      return -1;
    }
  
  if (*device__ < 0 || *device__ >= ctl_hw_info.pcmdevs)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL,
		"%d-th sound cards(%s) has %d pcm device(s)."
		" %d is invalid pcm device. assuming 0.",
		*card__, ctl_hw_info.longname, ctl_hw_info.pcmdevs, *device__);
      *device__ = 0;
      
      if (ctl_hw_info.pcmdevs == 0)
	{/*sound card has no pcm devices*/
	  snd_ctl_close (ctl_handle);
	  return -1;
	}
    }

  /*check whether pcm device is able to playback*/
  tmp = snd_ctl_pcm_info(ctl_handle, *device__, &pcm_info);
  if (tmp != 0)
    {
      error_report (tmp);
      snd_ctl_close (ctl_handle);
      return -1;
    }
  
  if ((pcm_info.flags & SND_PCM_INFO_PLAYBACK) == 0)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL,
		"%d-th sound cards(%s), device=%d, "
		"type=%d, flags=%d, id=%s, name=%s,"
		" does not support playback",
		*card__, ctl_hw_info.longname, ctl_hw_info.pcmdevs,
		pcm_info.type, pcm_info.flags, pcm_info.id, pcm_info.name);
      snd_ctl_close (ctl_handle);
      return -1;
    }
  
  tmp = snd_ctl_close (ctl_handle);
  if (tmp != 0)
    {
      error_report (tmp);
      return -1;
    }

  return 0;
}

/*return value == 0 sucess
               == 1 warning
               == -1 fails
 */
static int set_playback_info (snd_pcm_t* handle__,
			      uint32* encoding__, uint32* rate__,
			      const int32 extra_param[5])
{
  int ret_val = 0;
  const uint32 orig_encoding = *encoding__;
  const uint32 orig_rate = *rate__;
  /* snd_pcm_playback_info_t playback_info; */
  snd_pcm_channel_info_t playback_info;
  snd_pcm_format_t pcm_format;
  /*
  struct snd_pcm_playback_params playback_params;
  struct snd_pcm_playback_status playback_status;
  */
  struct snd_pcm_channel_params playback_params;
  struct snd_pcm_channel_status playback_status;
  struct snd_pcm_channel_setup setup;
  int tmp;

//fprintf(stderr,"setting playback info\n");
  memset (&pcm_format, 0, sizeof (pcm_format));
  pcm_format.interleave = 1;

  memset (&playback_params, 0, sizeof (playback_params));
  playback_params.channel = SND_PCM_CHANNEL_PLAYBACK;
  playback_params.mode = SND_PCM_MODE_BLOCK;

  memset(&playback_info, 0, sizeof(playback_info));
  playback_info.channel = SND_PCM_CHANNEL_PLAYBACK;

  tmp = snd_pcm_plugin_info (handle__, &playback_info);
//fprintf(stderr,"tmp = %d from snd_pcm_channel_info\n",tmp);
  if (tmp != 0)
    {
      error_report (tmp);
      return -1;
    }

  /*check sample bit*/
#if 0
  if ((playback_info.flags & SND_PCM_PINFO_8BITONLY) != 0)
    *encoding__ &= ~PE_16BIT;/*force 8bit samles*/
  if ((playback_info.flags & SND_PCM_PINFO_16BITONLY) != 0)
    *encoding__ |= PE_16BIT;/*force 16bit samples*/
#endif

  /*check rate*/
  if (playback_info.min_rate > *rate__)
    *rate__ = playback_info.min_rate;
  if (playback_info.max_rate < *rate__)
    *rate__ = playback_info.max_rate;
  pcm_format.rate = *rate__;

  /*check channels*/
  if ((*encoding__ & PE_MONO) != 0 && playback_info.min_voices > 1)
    *encoding__ &= ~PE_MONO;
  if ((*encoding__ & PE_MONO) == 0 && playback_info.max_voices < 2)
    *encoding__ |= PE_MONO;

  if ((*encoding__ & PE_MONO) != 0)
    pcm_format.voices = 1;/*mono*/
  else
    pcm_format.voices = 2;/*stereo*/


  /*check format*/
  if ((*encoding__ & PE_16BIT) != 0)
    {/*16bit*/
      if ((playback_info.formats & SND_PCM_FMT_S16_LE) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_S16_LE;
	  *encoding__ |= PE_SIGNED;
	}
      else if ((playback_info.formats & SND_PCM_FMT_U16_LE) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_U16_LE;
	  *encoding__ &= ~PE_SIGNED;
	}
      else if ((playback_info.formats & SND_PCM_FMT_S16_BE) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_S16_BE;
	  *encoding__ |= PE_SIGNED;
	}
      else if ((playback_info.formats & SND_PCM_FMT_U16_BE) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_U16_LE;
	  *encoding__ &= ~PE_SIGNED;
	}
      else
	{
	  ctl->cmsg(CMSG_ERROR, VERB_NORMAL,
		    "%s doesn't support 16 bit sample width",
		    dpm.name);
	  return -1;
	}
    }
  else
    {/*8bit*/
      if ((playback_info.formats & SND_PCM_FMT_U8) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_U8;
	  *encoding__ &= ~PE_SIGNED;
	}
      else if ((playback_info.formats & SND_PCM_FMT_S8) != 0)
	{
	  pcm_format.format = SND_PCM_SFMT_U16_LE;
	  *encoding__ |= PE_SIGNED;
	}
      else
	{
	  ctl->cmsg(CMSG_ERROR, VERB_NORMAL,
		    "%s doesn't support 8 bit sample width",
		    dpm.name);
	  return -1;
	}
    }
  memcpy(&playback_params.format, &pcm_format, sizeof(pcm_format));

#if 0
  tmp = snd_pcm_channel_format (handle__, &pcm_format);
  if (tmp != 0)
    {
      error_report (tmp);
      return -1;
    }
#endif

  /*check result of snd_pcm_channel_format*/
  if ((*encoding__ & PE_16BIT) != (orig_encoding & PE_16BIT ))
    {
      ctl->cmsg (CMSG_WARNING, VERB_VERBOSE,
		 "Sample width adjusted to %d bits",
		 ((*encoding__ & PE_16BIT) != 0)? 16:8);
      ret_val = 1;
    }
  if (((pcm_format.voices == 1)? PE_MONO:0) != (orig_encoding & PE_MONO))
    {
      ctl->cmsg(CMSG_WARNING, VERB_VERBOSE, "Sound adjusted to %sphonic",
		((*encoding__ & PE_MONO) != 0)? "mono" : "stereo");
      ret_val = 1;
    }
  
  /* Set buffer fragments (in extra_param[0]) */
#if 0
  tmp = AUDIO_BUFFER_BITS;
  if (!(*encoding__ & PE_MONO))
    tmp++;
  if (*encoding__ & PE_16BIT)
    tmp++;
  tmp++;
  playback_params.buf.block.frag_size = (1 << tmp);
#endif
  tmp = AUDIO_BUFFER_SIZE;
  if (!(*encoding__ & PE_MONO))
    tmp *=2;
  if (*encoding__ & PE_16BIT)
    tmp *=2;
  playback_params.buf.block.frag_size = tmp;
//fprintf(stderr,"frag_size %d\n", playback_params.buf.block.frag_size);

  if (extra_param[0] == 0)
    playback_params.buf.block.frags_max = 7;/*default value. What's value is apporpriate?*/
  else
    playback_params.buf.block.frags_max = extra_param[0];

#if 0
  if (extra_param[0] == 0)
    playback_params.fragments_max = 15;/*default value. What's value is apporpriate?*/
  else
    playback_params.fragments_max = extra_param[0];
#endif
  playback_params.buf.block.frags_min = 1;
  snd_pcm_plugin_flush(handle__, SND_PCM_CHANNEL_PLAYBACK);

  playback_params.start_mode = SND_PCM_START_FULL;
  playback_params.stop_mode = SND_PCM_STOP_STOP;
  //playback_params.stop_mode = SND_PCM_STOP_ROLLOVER;

  tmp = snd_pcm_channel_params (handle__, &playback_params);

//fprintf(stderr,"tmp = %d from snd_pcm_channel_params\n",tmp);
  if (tmp != 0)
    {
      ctl->cmsg(CMSG_WARNING, VERB_NORMAL,
		"%s doesn't support buffer fragments"
		":request size=%d, max=%d, room=%d\n",
		dpm.name,
		playback_params.buf.block.frag_size,
		playback_params.buf.block.frags_max,
		playback_params.buf.block.frags_min);
      ret_val =1;
    }


  if (snd_pcm_plugin_prepare(handle__, SND_PCM_CHANNEL_PLAYBACK) < 0) {
      fprintf(stderr, "unable to prepare channel\n");
      return -1;
  } 

  memset(&setup, 0, sizeof(setup));
  setup.channel = SND_PCM_CHANNEL_PLAYBACK;
  setup.mode = SND_PCM_MODE_BLOCK;
  if (snd_pcm_plugin_setup(handle__, &setup) < 0) {
      fprintf(stderr, "unable to obtain setup\n");
      return -1;
  }
  setup_frags = setup.buf.block.frags;
  setup_frag_size = setup.buf.block.frag_size;

//fprintf(stderr, "setup frags = %d\n", setup.buf.block.frags);
//fprintf(stderr, "setup frag_size = %d\n", setup.buf.block.frag_size);

  if(snd_pcm_plugin_status(handle__, &playback_status) == 0)
    {
      if (setup.format.rate != orig_rate)
	{
	  ctl->cmsg(CMSG_WARNING, VERB_VERBOSE,
		    "Output rate adjusted to %d Hz (requested %d Hz)",
		    setup.format.rate, orig_rate);
	  dpm.rate = setup.format.rate;
	  ret_val = 1;
	}
      total_bytes = playback_status.count;
    }
  else
    total_bytes = -1; /* snd_pcm_channel_status fails */

  return ret_val;
}

static int open_output(void)
{
  int tmp, warnings=0;
  int ret;
 
  tmp = check_sound_cards (&card, &device, dpm.extra_param);
  if (tmp != 0)
    return -1;

//fprintf(stderr,"using card %d, device %d\n", card, device);
  /* Open the audio device */
  ret = snd_pcm_open (&handle, card, device,
  	SND_PCM_OPEN_PLAYBACK|SND_PCM_OPEN_NONBLOCK);
//  ret = snd_pcm_open (&handle, card, device, SND_PCM_OPEN_PLAYBACK);
//fprintf(stderr,"ret was %d\n", ret);

  if (ret != 0)
    {
      ctl->cmsg(CMSG_ERROR, VERB_NORMAL, "%s: %s",
		dpm.name, snd_strerror (ret));
      return -1;
    }

  /* They can't mean these */
  dpm.encoding &= ~(PE_ULAW|PE_ALAW|PE_BYTESWAP);
  warnings = set_playback_info (handle, &dpm.encoding, &dpm.rate,
				dpm.extra_param);
  if (warnings == -1)
    {
      close_output ();
      return -1;
    }

  dpm.fd = snd_pcm_file_descriptor (handle, SND_PCM_CHANNEL_PLAYBACK);
  output_counter = 0;
  return warnings;
}

static void close_output(void)
{
  int ret;
  
  if (handle == NULL)
    return;
  
  ret = snd_pcm_close (handle);
  if (ret != 0)
    error_report (ret);
  handle = NULL;
  
  dpm.fd = -1;
}

#ifdef ORIG_TIMPP
static int output_data(char *buf, int32 nbytes)
{
    int n;

    while(nbytes > 0)
    {
	n = snd_pcm_plugin_write(handle, buf, nbytes);
	if(n == -1)
	{
	    ctl->cmsg(CMSG_WARNING, VERB_DEBUG,
		      "%s: %s", dpm.name, strerror(errno));
	    if(errno == EWOULDBLOCK)
		continue;
	    return -1;
	}
	buf += n;
	nbytes -= n;
	output_counter += n;
    }

    return 0;
}
#else

void playback_write_error(void)
{
	snd_pcm_channel_status_t status;
	
	memset(&status, 0, sizeof(status));
        status.channel = SND_PCM_CHANNEL_PLAYBACK;
	if (snd_pcm_plugin_status(handle, &status)<0) {
		fprintf(stderr, "playback channel status error\n");
		exit(1);
	}
	if (status.status == SND_PCM_STATUS_UNDERRUN) {
		//printf("underrun at position %u!!!\n", status.scount);
		if (snd_pcm_plugin_prepare(handle, SND_PCM_CHANNEL_PLAYBACK)<0) {
			fprintf(stderr, "underrun: playback channel prepare error\n");
			exit(1);
		}
		return;		/* ok, data should be accepted again */
	}
	if (status.status == SND_PCM_STATUS_READY) {
		if (snd_pcm_plugin_prepare(handle, SND_PCM_CHANNEL_PLAYBACK)<0) {
			fprintf(stderr, "ready: playback channel prepare error\n");
			exit(1);
		}
		return;		/* ok, data should be accepted again */
	}
	if (status.status == SND_PCM_STATUS_RUNNING) return;
	fprintf(stderr, "write error: status %d\n", status.status);
	exit(1);
}



static int driver_output_data(unsigned char *buf, uint32 count) {
	int ret_value;
//fprintf(stderr,"write %d bytes with buffer size %d\n",
//		count, AUDIO_BUFFER_SIZE);
  if (count < (uint32)setup_frag_size ) return 0;
  ret_value = snd_pcm_plugin_write(handle, buf, setup_frag_size);
  if (ret_value < 0) {
//fprintf(stderr,"ret_value = %d\n", ret_value);
    playback_write_error();	  
    ret_value = 0;
  }
  return ret_value;
}


static int output_count(uint32 ct)
{
  struct snd_pcm_channel_status playback_status;
  int samples = -1;
  int samples_queued, samples_sent = (int)ct;

  samples = samples_sent = b_out_count();

  if (samples_sent) {
	if(snd_pcm_plugin_status(handle, &playback_status) != 0)
	  return -1;
/* samples_queued is PM_REQ_GETFILLED */
      /* if (snd_pcm_channel_status(handle, &playback_status) == 0) */
	samples_queued = playback_status.count;
      samples -= samples_queued;
  }
  if (!(dpm.encoding & PE_MONO)) samples >>= 1;
  if (dpm.encoding & PE_16BIT) samples >>= 1;
  return samples;
}


static void output_data(int32 *buf, uint32 count)
{
  int ocount;

  if (!(dpm.encoding & PE_MONO)) count*=2; /* Stereo samples */
  ocount = (int)count;

  if (ocount) {
    if (dpm.encoding & PE_16BIT)
      {
        /* Convert data to signed 16-bit PCM */
        s32tos16(buf, count);
        ocount *= 2;
      }
    else
      {
        /* Convert to 8-bit unsigned and write out. */
        s32tou8(buf, count);
      }
  }

  b_out(dpm.id_character, dpm.fd, (int *)buf, ocount);
}


static void flush_output(void)
{
  output_data(0, 0);
  snd_pcm_plugin_flush(handle, SND_PCM_CHANNEL_PLAYBACK);
}

static void purge_output(void)
{
  b_out(dpm.id_character, dpm.fd, 0, -1);
  snd_pcm_plugin_playback_drain(handle);

  if (snd_pcm_plugin_prepare(handle, SND_PCM_CHANNEL_PLAYBACK) < 0) {
      fprintf(stderr, "unable to prepare channel\n");
      exit (1);
  } 

//fprintf(stderr, "setup frags = %d\n", setup.buf.block.frags);
}

#endif

#ifdef ORIG_TIMPP
static int acntl(int request, void *arg)
{
    struct snd_pcm_playback_status playback_status;
    int i;

    switch(request)
    {
      case PM_REQ_GETQSIZ:
	if(total_bytes == -1)
	  return -1;
	*((int *)arg) = total_bytes;
	return 0;

      case PM_REQ_GETFILLABLE:
	if(total_bytes == -1)
	  return -1;
	if(snd_pcm_playback_status(handle, &playback_status) != 0)
	  return -1;
	*((int *)arg) = playback_status.count;
	return 0;

      case PM_REQ_GETFILLED:
	if(total_bytes == -1)
	  return -1;
	if(snd_pcm_playback_status(handle, &playback_status) != 0)
	  return -1;
	*((int *)arg) = playback_status.queue;
	return 0;

      case PM_REQ_GETSAMPLES:
	if(total_bytes == -1)
	  return -1;
	if(snd_pcm_playback_status(handle, &playback_status) != 0)
	  return -1;
	i = output_counter - playback_status.queue;
	if(!(dpm.encoding & PE_MONO)) i >>= 1;
	if(dpm.encoding & PE_16BIT) i >>= 1;
	*((int *)arg) = i;
	return 0;

      case PM_REQ_DISCARD:
	if(snd_pcm_drain_playback (handle) != 0)
	    return -1; /* error */
	output_counter = 0;
	return 0;

      case PM_REQ_FLUSH:
	if(snd_pcm_flush_playback(handle) != 0)
	  return -1; /* error */
	output_counter = 0;
	return 0;
    }
    return -1;
}
#endif
#endif
