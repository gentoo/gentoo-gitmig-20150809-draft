
/*
 *  Copyright (C) 1998-2000 Luca Deri <deri@ntop.org>
 *                          Portions by Stefano Suin <stefano@ntop.org>
 *
 *		  	  Centro SERRA, University of Pisa
 *		 	  http://www.ntop.org/
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/*
 * Copyright (c) 1994, 1996
 *	The Regents of the University of California.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that: (1) source code distributions
 * retain the above copyright notice and this paragraph in its entirety, (2)
 * distributions including binary code include the above copyright notice and
 * this paragraph in its entirety in the documentation or other materials
 * provided with the distribution, and (3) all advertising materials mentioning
 * features or use of this software display the following acknowledgement:
 * ``This product includes software developed by the University of California,
 * Lawrence Berkeley Laboratory and its contributors.'' Neither the name of
 * the University nor the names of its contributors may be used to endorse
 * or promote products derived from this software without specific prior
 * written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#include "ntop.h"
#include "globals-report.h"


#if defined(NEED_INET_ATON)
/*
 * Minimal implementation of inet_aton.
 * Cannot distinguish between failure and a local broadcast address.
 */

#ifndef INADDR_NONE
#define INADDR_NONE 0xffffffff
#endif


static int inet_aton(const char *cp, struct in_addr *addr)
{
  addr->s_addr = inet_addr(cp);
  return (addr->s_addr == INADDR_NONE) ? 0 : 1;
}
#else
in_addr_t inet_aton(const char *cp, struct in_addr *addr);
#endif

/* That's the meat */
int main(int argc, char *argv[]) {
  int pflag, i;
#ifdef WIN32
  int optind=0;
#endif
  int op, enableDBsupport=0, mergeInterfaces=1;
  char *cp, *localAddresses=NULL, *webAddr=NULL, *devices;
  char flowSpecs[2048], rulesFile[128];
  time_t lastTime;

#ifndef WIN32
  if (freopen("/dev/null", "w", stderr) == NULL) {
    printf("ntop: unable to replace stderr with /dev/null: %s\n",
	   strerror(errno));
  }
#endif

  webPort = NTOP_DEFAULT_WEB_PORT;

  /* Initialization of local variables */
  isLsofPresent  = checkCommand("lsof");
  /* LUCA LUCA */ isLsofPresent = 0;
  isNepedPresent = checkCommand("neped");
  isNmapPresent  = checkCommand("nmap");

  rulesFile[0] = '\0';
  flowSpecs[0] = '\0';
  flowsList = NULL;
  localAddrFlag = 1;
  logTimeout = 0;
  tcpChain = NULL, udpChain = NULL, icmpChain = NULL;
  devices = NULL;

  daemonMode = 0, pflag = 0, numericFlag=0, percentMode = 0;
  refreshRate = 0, idleFlag = 1, logd = NULL;
  rFileName=NULL;

  domainName[0] = '\0';

  actTime = time(NULL);
  strcpy(dbPath, ".");

  if ((cp = strrchr(argv[0], '/')) != NULL)
    program_name = cp + 1;
  else
    program_name = argv[0];

  if(strcmp(program_name, "ntopd") == 0) {
    daemonMode++;
  }

  initIPServices();

#ifdef WIN32
  while ((op = getopt(argc, argv, "e:F:hr:p:l:nw:m:b:B:D:s:P:R:")) != EOF)
#else
  while ((op = getopt(argc, argv, "Ide:f:F:hr:i:p:l:nNw:m:b:D:s:P:R:M")) != EOF)
#endif
    switch (op) {
      /* Courtesy of Ralf Amandi <Ralf.Amandi@accordata.net> */
    case 'P': /* DB-Path */
      strcpy(dbPath, optarg);
      break;

#ifndef WIN32
    case 'd':
	daemonMode=1;
      break;

    case 'I': /* Interactive mode */
      printf("intop provides you curses support. ntop -I is no longer used.\n");
      return(-1);
#endif

#ifdef WIN32
    case 'B':
      SIZE_BUF=atoi(optarg)*1024;
    break;
#endif

    case 'b': /* host:port */
      handleDbSupport(optarg, &enableDBsupport);
      break;

    case 'D': /* domain */
      strcpy(domainName, optarg);
      break;

    case 'f':
      isLsofPresent = 0; /* Don't make debugging too complex */
      rFileName = optarg;
      break;

    case 'r':
      if(!isdigit(optarg[0])) {
	printf("FATAL ERROR: flag -r expects a numeric argument.\n");
	exit(-1);
      }
      refreshRate = atoi(optarg);
      break;

    case 'e':
      maxNumLines = atoi(optarg);
      break;

    case 's':
      actualHashSize = atoi(optarg);
      if((actualHashSize > HASHNAMESIZE)
	 || (actualHashSize < 1024)) {
	printf("Acceptable values for the 's' flag are\n"
	       "between 1024 and %d\n", HASHNAMESIZE);
	exit(-1);
      }
      break;

#ifndef WIN32
    case 'i':
      devices = optarg;
      break;
#endif

    case 'p':
      handleProtocols(optarg);
      break;

    case 'F':
      strcpy(flowSpecs, optarg);
      break;

    case 'm':
      localAddresses = strdup(optarg);
      break;

    case 'l':
      if(!isdigit(optarg[0])) {
		printf("FATAL ERROR: flag -l expects a numeric argument.\n");
		exit(-1);
      }

      logTimeout = atoi(optarg);

      if(logTimeout < 0) {
		printf("Log period out of range: set to default (30 mins)\n");
		logTimeout = 1800; /* seconds */
      }

      logd = fopen("ntop.log", "w+");
      if(logd == NULL) {
	printf("Logging disabled: unable to log onto file ntop.log.\n");
	logTimeout = 0;
      } else
	printLogHeader();
      break;

    case 'n':
      numericFlag++;
      break;

    case 'N':
      isNmapPresent = 0;
      break;

    case 'w':
      if(!isdigit(optarg[0])) {
	printf("FATAL ERROR: flag -w expects a numeric argument.\n");
	exit(-1);
      }

      /* Courtesy of Daniel Savard <daniel.savard@gespro.com> */
      if ((webAddr = strchr(optarg,':'))) {
	/* DS: Search for : to find xxx.xxx.xxx.xxx:port */
	*webAddr = '\0';  /* This code is to be able to bind to a particular interface */
	webPort = atoi(webAddr+1);
	webAddr = optarg;
      } else
         webPort = atoi(optarg);
      break;

    case 'R':
      strcpy(rulesFile, optarg);
      break;

    case 'M':
      mergeInterfaces = 0;
      break;

    default:
      usage();
      exit(-1);
      /* NOTREACHED */
    }


  /* ***************************** */

  initGlobalValues();
  reportValues(&lastTime);
  postCommandLineArgumentsInitialization(&lastTime);
  initGdbm();
  initializeWeb();
  initApps();
  initReports();
  initDevices(devices);

  printf("ntop v.%s %s [%s] listening on [",
	 version, THREAD_MODE, osName);
  
  if(rFileName != NULL)
    printf("%s", PCAP_NW_INTERFACE);
  else
    for(i=0; i<numDevices; i++) {
      if(i>0) printf(",");
      printf("%s", device[i].name);
    }
  
  printf("].\nCopyright 1998-2000 by %s\n", author);
  printf("Get the freshest ntop from http://www.ntop.org/\n\n");
  printf("Initialising...\n");

  initLibpcap(rulesFile, numDevices);

  if(localAddresses != NULL) {
    handleLocalAddresses(localAddresses);
    free(localAddresses);
    localAddresses = NULL;
  }

  initDeviceDatalink();
  parseTrafficFilter(argv, optind);

  /* Handle flows (if any) */
  if(flowSpecs[0] != '\0')
    handleFlowsSpecs(flowSpecs);

  loadPlugins();

  initCounters(mergeInterfaces);
  initLogger();
  initSignals();

  initThreads(enableDBsupport);

  initWeb(webPort, webAddr);

  printf("Sniffying...\n");


  /* 
     In multithread mode, a separate thread handles 
     packet sniffing 
  */
#ifndef MULTITHREADED
  packetCaptureLoop(&lastTime, refreshRate);
#else
  startSniffer();
  sleep(-1);
#endif

  pause ();

  return(0);
}

