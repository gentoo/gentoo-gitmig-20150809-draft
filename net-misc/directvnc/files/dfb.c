/* 
 * Copyright (C) 2001  Till Adam
 * Authors: Till Adam <till@adam-lilienthal.de>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include "directvnc.h"
#include <math.h>

/* DirectFB interfaces needed */
IDirectFB               *dfb = NULL;
IDirectFBSurface        *primary;
IDirectFBDisplayLayer   *layer;
IDirectFBInputDevice    *keyboard;
IDirectFBInputDevice    *mouse;
IDirectFBEventBuffer    *input_buffer;
DFBResult err;
DFBSurfaceDescription dsc;
DFBCardCapabilities caps;
DFBDisplayLayerConfig layer_config;
DFBRegion rect;
DFBRectangle scratch_rect;

void
dfb_init(int argc, char *argv[])
{
     DFBCHECK(DirectFBInit( &argc, &argv ));
     DFBCHECK(DirectFBSetOption ("quiet", ""));

     /* create the super interface */
     DFBCHECK(DirectFBCreate( &dfb ));

     dfb->SetCooperativeLevel(dfb, DFSCL_FULLSCREEN);

     DFBCHECK(dfb->GetDisplayLayer( dfb, DLID_PRIMARY, &layer ));
     layer->GetConfiguration (layer, &layer_config);

     /* get the primary surface, i.e. the surface of the primary layer we have
	exclusive access to */
     memset( &dsc, 0, sizeof(DFBSurfaceDescription) );     
     dsc.flags = 
	DSDESC_CAPS | DSDESC_WIDTH | DSDESC_HEIGHT | DSDESC_PIXELFORMAT;
     dsc.width = layer_config.width;
     dsc.height = layer_config.height;

     dsc.caps = DSCAPS_PRIMARY | DSCAPS_SYSTEMONLY /*| DSCAPS_FLIPPING */;
     /* FIXME */
     dsc.pixelformat = DSPF_RGB16;
         
     DFBCHECK(dfb->CreateSurface(dfb, &dsc, &primary ));
     primary->GetSize (primary, &opt.client.width, &opt.client.height);

     DFBCHECK(dfb->GetInputDevice( dfb, DIDID_KEYBOARD, &keyboard ));
     DFBCHECK(dfb->GetInputDevice( dfb, DIDID_MOUSE, &mouse ));
     DFBCHECK(keyboard->CreateEventBuffer(keyboard, &input_buffer));
     DFBCHECK(mouse->AttachEventBuffer(mouse, input_buffer));
}


/*
 * deinitializes resources and DirectFB
 */
void 
dfb_deinit()
{
     primary->Release( primary );
     input_buffer->Release(input_buffer);
     keyboard->Release( keyboard );
     mouse->Release(mouse);
     layer->Release( layer );
     dfb->Release( dfb ); 
}
 
void
dfb_flip()
{
   primary->Flip(primary, NULL, DSFLIP_WAITFORSYNC);
}

void
dfb_flip_rect(x, y, w, h)
{
   rect.x1 = x+opt.h_offset;
   rect.y1 = y+opt.v_offset;
   rect.x2 = x+w;
   rect.y2 = y+h;
   primary->Flip(primary, &rect, DSFLIP_WAITFORSYNC);
}

int
dfb_write_data_to_screen(int x, int y, int w, int h, void *data)
{
 
   char *dst;
   int pitch;         /* number of bytes per row */
   int src_pitch;     

   src_pitch = w * opt.client.bpp/8; 

   if(primary->Lock(primary, DSLF_WRITE, (void**)(&dst), &pitch) ==DFB_OK)
   {
      int i;
      dst += opt.v_offset * pitch;
      dst += (y*pitch + ( (x+opt.h_offset) * opt.client.bpp/8) );
      for (i=0;i<h;i++)
      {
	 memcpy (dst, data, src_pitch);
	 data += src_pitch;
	 dst += pitch ;
      }	
      primary->Unlock (primary);
   }
   dfb_flip (x,y,w,h);
   return 1;
}

int   
dfb_copy_rect(int src_x, int src_y, int dest_x, int dest_y, int w, int h)
{
   scratch_rect.x = src_x+opt.h_offset;
   scratch_rect.y = src_y+opt.v_offset;
   scratch_rect.w = w;
   scratch_rect.h = h;

   primary->Blit(primary, primary, &scratch_rect, 
	         dest_x+opt.h_offset, dest_y+opt.v_offset);
   dfb_flip (src_x,src_y,w,h);
   return 1;
}

int
dfb_process_events()
{
   DFBInputEvent evt;

   /* we need to check whether the dfb ressources have been set up because
    * this might be called during handshaking when dfb_init has not been
    * called yet. This is the disadvantage of processing client events
    * whenever the socket would block. The other option would be to initialize
    * the dfb ressources (input input_buffer) before everything else, but then the
    * screen gets blanked for every unsuccessful connect (wrong password)
    * which is not pretty either. I think I prefer checking here for the time
    * being. */
   if (!dfb)
      return 0;
   while(input_buffer->GetEvent(input_buffer, DFB_EVENT(&evt)) == DFB_OK)
   {
      switch (evt.type)
      {
	 case DIET_KEYPRESS:
	    /* quit on ctrl-q FIXME make this configurable*/
	    if (evt.key_id == DIKI_Q && evt.modifiers & DIMM_CONTROL)
	    {
	       dfb_deinit();
	       exit(1);
	    }
	    rfb_send_key_event(evt.key_symbol, 1); 
	    break;
	 case DIET_KEYRELEASE:
	    rfb_send_key_event(evt.key_symbol, 0); 
	    break;
	 case DIET_AXISMOTION:
	    if (evt.flags & DIEF_AXISREL)
	    {
	       switch (evt.axis)
	       {
		  case DIAI_X:
		     mousestate.x += evt.axisrel;	
		     break;
		  case DIAI_Y:
		     mousestate.y += evt.axisrel;
		     break;
		  default:
		     break;
	       }
	       rfb_update_mouse();
	    }
	    break;
	 case DIET_BUTTONPRESS:
	    switch (evt.button)
	    {
	       case DIBI_LEFT:	  
		  mousestate.buttonmask |= rfbButton1Mask;
		  break;
	       case DIBI_MIDDLE:
		  mousestate.buttonmask |= rfbButton2Mask;
		  break;
	       case DIBI_RIGHT:
		  mousestate.buttonmask |= rfbButton3Mask;
		  break;
	       default:
		  break;
	    }
	    rfb_update_mouse();
	    break;
	 case DIET_BUTTONRELEASE:
	    switch (evt.button)
	    {
	       case DIBI_LEFT: 	
		  mousestate.buttonmask &= ~rfbButton1Mask;
		  break;
	       case DIBI_MIDDLE:
		  mousestate.buttonmask &= ~rfbButton2Mask;
		  break;
	       case DIBI_RIGHT:
		  mousestate.buttonmask &= ~rfbButton3Mask;
		  break;
	       default:
		  break;
	    }
	    rfb_update_mouse();
	    break;
   
	 case DIET_UNKNOWN:  /* fallthrough */
	 default:
	    fprintf(stderr, "Unknown event: %d\n", evt.type);
	    break;
      }
   }
   return 1;
   
}

int
dfb_draw_rect_with_rgb(int x, int y, int w, int h, int r, int g, int b)
{
   primary->SetColor(primary, r,g,b,0xFF);
   primary->FillRectangle(primary, x+opt.h_offset,y+opt.v_offset,w,h);
   dfb_flip (x,y,w,h);
   return 1;
}

