#ifndef NMAP_H
#define NMAP_H

/************************INCLUDES**********************************/


#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <unistd.h>
#ifdef HAVE_GETOPT_H
#include <getopt.h>
#else
/* The next half-dozen lines are from gcc-2.95 ... -Fyodor */
/* Include getopt.h for the sake of getopt_long.
   We don't need the declaration of getopt, and it could conflict
   with something from a system header file, so effectively nullify that.  */
#define getopt getopt_loser
#include "getopt.h"
#undef getopt
#endif

#ifdef STDC_HEADERS
#include <stdlib.h>
#else
void *malloc();
void *realloc();
#endif

#if STDC_HEADERS || HAVE_STRING_H
#include <string.h>
#if !STDC_HEADERS && HAVE_MEMORY_H
#include <memory.h>
#endif
#endif
#if HAVE_STRINGS_H
#include <strings.h>
#endif

#ifdef HAVE_BSTRING_H
#include <bstring.h>
#endif

#ifndef HAVE_BZERO
#define bzero(s, n) memset((s), 0, (n))
#endif

#ifndef HAVE_MEMCPY
#define memcpy(d, s, n) bcopy((s), (d), (n))
#endif

#include <ctype.h>
#include <sys/types.h>

#include <sys/wait.h>

#ifdef HAVE_SYS_PARAM_H   
#include <sys/param.h> /* Defines MAXHOSTNAMELEN on BSD*/
#endif

/* Linux uses these defines in netinet/ip.h and netinet/tcp.h to
   use the correct struct ip and struct tcphdr */
#ifndef __FAVOR_BSD
#define __FAVOR_BSD
#endif
#ifndef __USE_BSD
#define __USE_BSD
#endif
#ifndef __BSD_SOURCE
#define __BSD_SOURCE
#endif

/* BSDI needs this to insure the correct struct ip */
#undef _IP_VHL

#if HAVE_STRINGS_H
#include <strings.h>
#endif

#include <stdio.h>
#include <rpc/types.h>
#include <sys/socket.h>
#include <sys/socket.h> 
#include <sys/stat.h>
#include <netinet/in.h>
#include <errno.h>
#include <netdb.h>

#if TIME_WITH_SYS_TIME
# include <sys/time.h>
# include <time.h>
#else
# if HAVE_SYS_TIME_H
#  include <sys/time.h>
# else
#  include <time.h>
# endif
#endif

#include <fcntl.h>
#include <signal.h> 
#include <signal.h>
#include <stdarg.h>
#include <pwd.h>
#ifndef NETINET_IN_SYSTEM_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/in_systm.h> /* defines n_long needed for netinet/ip.h */
#define NETINET_IN_SYSTEM_H
#endif
#ifndef NETINET_IP_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/ip.h> 
#define NETINET_IP_H
#endif
#include <netinet/ip_icmp.h> 
#include <arpa/inet.h>
#include <math.h>
#include <assert.h>
#ifndef __FAVOR_BSD
#define __FAVOR_BSD
#endif
#ifndef NETINET_TCP_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/tcp.h>          /*#include <netinet/ip_tcp.h>*/
#define NETINET_TCP_H
#endif
#include <sys/resource.h>
/*#include <net/if_arp.h> *//* defines struct arphdr needed for if_ether.h */
#ifndef NET_IF_H  /* why the HELL does OpenBSD not do this? */
#include <net/if.h>
#define NET_IF_H
#endif
#if HAVE_NETINET_IF_ETHER_H 
#ifndef NETINET_IF_ETHER_H
#include <netinet/if_ether.h>
#define NETINET_IF_ETHER_H
#endif /* NETINET_IF_ETHER_H */
#endif /* HAVE_NETINET_IF_ETHER_H */

#if !HAVE_VSNPRINTF
#define vsnprintf(str, n, format, ap) vsprintf(str, format, ap)
#endif


/*******  DEFINES  ************/

/* User configurable #defines: */
#ifndef VERSION
#define VERSION "1.60-Beta"
#endif
#ifndef DEBUGGING
#define DEBUGGING 0
#endif
/* Default number of ports in parallel.  Doesn't always involve actual 
   sockets.  Can also adjust with the -M command line option.  */
#define MAX_SOCKETS 36 
/* As an optimisation we limit the maximum value of MAX_SOCKETS to a very
   high value (avoids dynamic memmory allocation */
#define MAX_SOCKETS_ALLOWED 1025
/* How many hosts do we ping in parallel to see if they are up? */
#define LOOKAHEAD 25
/* If reads of a UDP port keep returning EAGAIN (errno 13), do we want to 
   count the port as valid? */
#define RISKY_UDP_SCAN 0
/* How many syn packets do we send to TCP sequence a host? */
#define NUM_SEQ_SAMPLES 6
 /* This ideally should be a port that isn't in use for any protocol on our machine or on the target */ 
#define MAGIC_PORT 49724
/* How many udp sends without a ICMP port unreachable error does it take before we consider the port open? */
#define UDP_MAX_PORT_RETRIES 4
 /*How many seconds before we give up on a host being alive? */

#define FAKE_ARGV "pine" /* What ps and w should show if you use -q */
/* How do we want to log into ftp sites for */ 
#define FTPUSER "anonymous"
#define FTPPASS "-wwwuser@"
#define FTP_RETRIES 2 /* How many times should we relogin if we lose control
                         connection? */
#define MAX_TIMEOUTS MAX_SOCKETS   /* How many timed out connection attempts 
				      in a row before we decide the host is 
				      dead? */
#define MAX_DECOYS 128 /* How many decoys are allowed? */

#ifndef MAX_RTT_TIMEOUT
#define MAX_RTT_TIMEOUT 10000 /* Never allow more than 10 secs for packet round
				 trip */
#endif

#ifndef MIN_RTT_TIMEOUT
#define MIN_RTT_TIMEOUT 300 /* We will always wait at least 300 ms for a response */
#endif

#define INITIAL_RTT_TIMEOUT 6000 /* Allow 6 seconds at first for packet responses */
#define HOST_TIMEOUT    0 /* By default allow unlimited time to scan each host */

/* If nmap is called with one of the names below, it will start up in interactive mode -- alternatively, you can rename Nmap any of the following names to have it start up interactivey by default.  */
#define INTERACTIVE_NAMES { "BitchX", "Calendar", "X", "awk", "bash", "bash2", "calendar", "cat", "csh", "elm", "emacs", "ftp", "fvwm", "g++", "gcc", "gimp", "httpd", "irc", "man", "mutt", "nc", "ncftp", "netscape", "perl", "pine", "ping", "sleep", "slirp", "ssh", "sshd", "startx", "tcsh", "telnet", "telnetd", "tia", "top", "vi", "vim", "xdvi", "xemacs", "xterm", "xv" }

/* Number of hosts we pre-ping and then scan.  We do a lot more if
   randomize_hosts is set.  Every one you add to this leads to ~1K of
   extra always-resident memory in nmap */
#define HOST_GROUP_SZ 256

/* DO NOT change stuff after this point */
#define UC(b)   (((int)b)&0xff)
#define SA    struct sockaddr  /*Ubertechnique from R. Stevens */
/*#define fatal(x) { fprintf(stderr, "%s\n", x); exit(-1); }
  #define error(x) fprintf(stderr, "%s\n", x);*/
/* hoststruct->flags stuff */
#define HOST_UP 1
#define HOST_DOWN 2 
#define HOST_FIREWALLED 4 
#define HOST_BROADCAST 8 /* use the wierd_responses member of hoststruct instead */

#define PINGTYPE_UNKNOWN 0
#define PINGTYPE_NONE 1
#define PINGTYPE_ICMP 2
#define PINGTYPE_TCP  4
#define PINGTYPE_TCP_USE_ACK 8
#define PINGTYPE_TCP_USE_SYN 16
#define PINGTYPE_RAWTCP 32
#define PINGTYPE_CONNECTTCP 64

#define SEQ_UNKNOWN 0
#define SEQ_64K 1
#define SEQ_TD 2
#define SEQ_RI 4
#define SEQ_TR 8
#define SEQ_i800 16
#define SEQ_CONSTANT 32

#ifndef MAXHOSTNAMELEN
#define MAXHOSTNAMELEN 64
#endif

#ifndef BSDFIX
#if FREEBSD || BSDI || NETBSD
#define BSDFIX(x) x
#define BSDUFIX(x) x
#else
#define BSDFIX(x) htons(x)
#define BSDUFIX(x) ntohs(x)
#endif
#endif /* BSDFIX */

#define LOG_TYPES 4
#define LOG_MASK 15
#define LOG_NORMAL 1
#define LOG_MACHINE 2
#define LOG_HTML 4
#define LOG_SKID 8
#define LOG_STDOUT 1024
#define LOG_SKID_NOXLT 2048

#define LOG_NAMES {"normal", "machine", "HTML", "$Cr!pT |<!dd!3"}
/********************** LOCAL INCLUDES *****************************/

#include "portlist.h"
#include "tcpip.h"
#include "global_structures.h"
#include "error.h"
#include "utils.h"
#include "services.h"
#include "rpc.h"
#include "targets.h"

/***********************STRUCTURES**********************************/

/* Moved to global_structures.h */

/***********************PROTOTYPES**********************************/

/* print usage information and exit */
void printusage(char *name, int rc);
/* print Interactive usage information */
void printinteractiveusage();

/* our scanning functions */
void super_scan(struct hoststruct *target, unsigned short *portarray, 
		stype scantype);
void pos_scan(struct hoststruct *target, unsigned short *portarray, 
	      stype scantype);
void bounce_scan(struct hoststruct *target, unsigned short *portarray,
		     struct ftpinfo *ftp);

/* Scan helper functions */
unsigned long calculate_sleep(struct in_addr target);
int check_ident_port(struct in_addr target);
int getidentinfoz(struct in_addr target, int localport, int remoteport,
		  char *owner);
int parse_bounce(struct ftpinfo *ftp, char *url);
int ftp_anon_connect(struct ftpinfo *ftp);
/* Does the appropriate stuff when the port we are looking at is found
   to be open trynum is the try number that was successful */
void posportupdate(struct hoststruct *target, struct portinfo *current, 
		   int trynum, struct portinfo *scan,
		   struct scanstats *ss ,stype scantype, int newstate,
		   struct portinfolist *pil, struct connectsockinfo *csi);
void get_syn_results(struct hoststruct *target, struct portinfo *scan,
		     struct scanstats *ss, struct portinfolist *pil, 
		     int *portlookup, pcap_t *pd, unsigned long *sequences, stype scantype);
int get_connect_results(struct hoststruct *target, struct portinfo *scan, 
			 struct scanstats *ss, struct portinfolist *pil, 
			 int *portlookup, unsigned long *sequences, 
			 struct connectsockinfo *csi);
inline void adjust_timeouts(struct timeval sent, struct timeout_info *to);
/* port manipulators */
unsigned short *getpts(char *expr); /* someone stole the name getports()! */

void printportoutput(struct hoststruct *currenths, portlist *plist);

/* socket manipulation functions */
void init_socket(int sd);
int unblock_socket(int sd);
int block_socket(int sd);
void broadcast_socket(int sd);
int recvtime(int sd, char *buf, int len, int seconds);
void max_rcvbuf(int sd);
int max_sd();
int log_open(int logt, int append, char *filename);
/* RAW packet building/dissasembling stuff */
int isup(struct in_addr target);
int listen_icmp(int icmpsock, unsigned short outports[],
		unsigned short numtries[], int *num_out,
		struct in_addr target, portlist *ports);

/* Renamed main so that interactive mode could preprocess when neccessary */
int nmap_main(int argc, char *argv[]);

/* general helper functions */
void hdump(unsigned char *packet, int len);
void *safe_malloc(int size);
char *grab_next_host_spec(FILE *inputfd, int argc, char **fakeargv);
int parse_targets(struct targets *targets, char *h);
void options_init();
void nmap_log(char *fmt, ...);
void nmap_machine_log(char *fmt, ...);
char *statenum2str(int state);
void sigdie(int signo);
void reaper(int signo);
char *seqreport(struct seq_info *seq);
char *seqclass2ascii(int clas);
int nmap_fetchfile(char *filename_returned, int bufferlen, char *file);
int fileexistsandisreadable(char *pathname);
void enforce_scan_delay(struct timeval *tv);
int check_firewallmode(struct hoststruct *target, struct scanstats *ss);
int gather_logfile_resumption_state(char *fname, int *myargc, char ***myargv);

/* The items in ports should be
   in sequential order for space savings and easier to read output */
void output_rangelist_given_ports_to_machine_output(unsigned short *ports,
						    int numports);
/* Output the list of ports scanned to the top of machine parseable
   logs (in a comment, unfortunately).  The items in ports should be
   in sequential order for space savings and easier to read output */
void output_ports_to_machine_parseable_output(unsigned short *ports, 
					      int numports, int tcpscan, 
					      int udpscan);

void log_write(int logt, char *fmt, ...);
void log_close(int logt);
void log_flush(int logt);
void log_flush_all();
void skid_output(unsigned char *s);

/* From glibc 2.0.6 because Solaris doesn't seem to have this function */
#ifndef HAVE_INET_ATON
in_addr_t inet_aton(register const char *, struct in_addr *);
#endif
#ifndef HAVE_SNPRINTF
int snprintf ( char *str, size_t n, const char *format, ... );
#endif
#endif /* NMAP_H */








