#ifndef TCPIP_H
#define TCPIP_H

#ifdef HAVE_CONFIG_H
#include "config.h"
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

#ifdef HAVE_SYS_PARAM_H
#include <sys/param.h> /* Defines MAXHOSTNAMELEN on BSD*/
#endif

/* Linux uses these defines in netinet/ip.h and netinet/tcp.h to
   use the correct struct ip and struct tcphdr */
#ifndef __FAVOR_BSD
#define __FAVOR_BSD 1
#endif
#ifndef __BSD_SOURCE
#define __BSD_SOURCE 1
#endif
#ifndef __USE_BSD
#define __USE_BSD 1
#endif
/* BSDI needs this to insure the correct struct ip */
#undef _IP_VHL

#include <stdio.h>
#include <netinet/in.h>
#include <rpc/types.h>
#include <netdb.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#ifndef NETINET_IN_SYSTEM_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/in_systm.h> /* defines n_long needed for netinet/ip.h */
#define NETINET_IN_SYSTEM_H
#endif
#ifndef NETINET_IP_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/ip.h>
#define NETINET_IP_H
#endif
#ifndef __FAVOR_BSD
#define __FAVOR_BSD
#endif
#ifndef NETINET_TCP_H  /* why the HELL does OpenBSD not do this? */
#include <netinet/tcp.h>          /*#include <netinet/ip_tcp.h>*/
#define NETINET_TCP_H
#endif
#ifndef NETINET_UDP_H
#include <netinet/udp.h>
#define NETINET_UDP_H
#endif
#include <unistd.h>
#include <fcntl.h>
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

#include <sys/ioctl.h>
#include <pcap.h>
#include <setjmp.h>
#include <errno.h>
#include <signal.h>
#include <pcap.h>
#if HAVE_SYS_SOCKIO_H
#include <sys/sockio.h>  /* SIOCGIFCONF for Solaris */
#endif
#include "error.h"
#include "utils.h"
#include "nmap.h"
#include "global_structures.h"

#ifndef DEBUGGING
#define DEBUGGING 0
#endif

#ifndef TCPIP_DEBUGGING
#define TCPIP_DEBUGGING 0
#endif

#ifndef BSDFIX
#if FREEBSD || BSDI || NETBSD
#define BSDFIX(x) x
#define BSDUFIX(x) x
#else
#define BSDFIX(x) htons(x)
#define BSDUFIX(x) ntohs(x)
#endif
#endif

/* Bogus TCP flag!!!  Krad! */
#define TH_BOGUS 64
#define TH_BOG 64

#define MORE_FRAGMENTS 8192 /*NOT a user serviceable parameter*/

struct interface_info {
    char name[64];
    struct in_addr addr;
};




#ifndef HAVE_STRUCT_IP
#define HAVE_STRUCT_IP

/* From Linux glibc, which apparently borrowed it from
   BSD code.  Slightly modified for portability --fyodor@dhp.com */
/*
 * Structure of an internet header, naked of options.
 */
struct ip
  {
#if WORDS_BIGENDIAN
    u_int8_t ip_v:4;                    /* version */
    u_int8_t ip_hl:4;                   /* header length */
#else
    u_int8_t ip_hl:4;                   /* header length */
    u_int8_t ip_v:4;                    /* version */ 
#endif
    u_int8_t ip_tos;                    /* type of service */
    u_short ip_len;                     /* total length */
    u_short ip_id;                      /* identification */
    u_short ip_off;                     /* fragment offset field */
#define IP_RF 0x8000                    /* reserved fragment flag */
#define IP_DF 0x4000                    /* dont fragment flag */
#define IP_MF 0x2000                    /* more fragments flag */
#define IP_OFFMASK 0x1fff               /* mask for fragmenting bits */
    u_int8_t ip_ttl;                    /* time to live */
    u_int8_t ip_p;                      /* protocol */
    u_short ip_sum;                     /* checksum */
    struct in_addr ip_src, ip_dst;      /* source and dest address */
  };

#endif /* HAVE_STRUCT_IP */

#ifdef LINUX
typedef struct udphdr_bsd {
         unsigned short uh_sport;           /* source port */
         unsigned short uh_dport;           /* destination port */
         unsigned short uh_ulen;            /* udp length */
         unsigned short uh_sum;             /* udp checksum */
} udphdr_bsd;
#else
 typedef struct udphdr udphdr_bsd;
#endif 


#ifndef HAVE_STRUCT_ICMP
#define HAVE_STRUCT_ICMP
/* From Linux /usr/include/netinet/ip_icmp.h GLIBC */

/*
 * Internal of an ICMP Router Advertisement
 */
struct icmp_ra_addr
{
  u_int32_t ira_addr;
  u_int32_t ira_preference;
};

struct icmp
{
  u_int8_t  icmp_type;  /* type of message, see below */
  u_int8_t  icmp_code;  /* type sub code */
  u_int16_t icmp_cksum; /* ones complement checksum of struct */
  union
  {
    u_char ih_pptr;             /* ICMP_PARAMPROB */
    struct in_addr ih_gwaddr;   /* gateway address */
    struct ih_idseq             /* echo datagram */
    {
      u_int16_t icd_id;
      u_int16_t icd_seq;
    } ih_idseq;
    u_int32_t ih_void;

    /* ICMP_UNREACH_NEEDFRAG -- Path MTU Discovery (RFC1191) */
    struct ih_pmtu
    {
      u_int16_t ipm_void;
      u_int16_t ipm_nextmtu;
    } ih_pmtu;

    struct ih_rtradv
    {
      u_int8_t irt_num_addrs;
      u_int8_t irt_wpa;
      u_int16_t irt_lifetime;
    } ih_rtradv;
  } icmp_hun;
#define icmp_pptr       icmp_hun.ih_pptr
#define icmp_gwaddr     icmp_hun.ih_gwaddr
#define icmp_id         icmp_hun.ih_idseq.icd_id
#define icmp_seq        icmp_hun.ih_idseq.icd_seq
#define icmp_void       icmp_hun.ih_void
#define icmp_pmvoid     icmp_hun.ih_pmtu.ipm_void
#define icmp_nextmtu    icmp_hun.ih_pmtu.ipm_nextmtu
#define icmp_num_addrs  icmp_hun.ih_rtradv.irt_num_addrs
#define icmp_wpa        icmp_hun.ih_rtradv.irt_wpa
#define icmp_lifetime   icmp_hun.ih_rtradv.irt_lifetime
  union
  {
    struct
    {
      u_int32_t its_otime;
      u_int32_t its_rtime;
      u_int32_t its_ttime;
    } id_ts;
    struct
    {
      struct ip idi_ip;
      /* options and then 64 bits of data */
    } id_ip;
    struct icmp_ra_addr id_radv;
    u_int32_t   id_mask;
    u_int8_t    id_data[1];
  } icmp_dun;
#define icmp_otime      icmp_dun.id_ts.its_otime
#define icmp_rtime      icmp_dun.id_ts.its_rtime
#define icmp_ttime      icmp_dun.id_ts.its_ttime
#define icmp_ip         icmp_dun.id_ip.idi_ip
#define icmp_radv       icmp_dun.id_radv
#define icmp_mask       icmp_dun.id_mask
#define icmp_data       icmp_dun.id_data
};
#endif /* HAVE_STRUCT_ICMP */

 /* This ideally should be a port that isn't in use for any protocol on our machine or on the target */
#define MAGIC_PORT 49724
#define TVAL2LONG(X)  X.tv_sec * 1e6 + X.tv_usec
#define SA struct sockaddr

/* Prototypes */

/* Tries to resolve given hostname and stores
   result in ip .  returns 0 if hostname cannot
   be resolved */
int resolve(char *hostname, struct in_addr *ip);
/* An awesome function to determine what interface a packet to a given
   destination should be routed through.  It returns NULL if no appropriate
   interface is found, oterwise it returns the device name and fills in the
   source parameter */
char *routethrough(struct in_addr *dest, struct in_addr *source);
unsigned short in_cksum(unsigned short *ptr,int nbytes);
int send_tcp_raw( int sd, struct in_addr *source, 
		  struct in_addr *victim, unsigned short sport, 
		  unsigned short dport, unsigned int seq,
		  unsigned int ack, unsigned char flags,
		  unsigned short window, char *options, int optlen,
		  char *data, unsigned short datalen);
int send_udp_raw( int sd, struct in_addr *source, 
		  struct in_addr *victim, unsigned short sport, 
		  unsigned short dport, char *data, unsigned short datalen);
int send_small_fragz(int sd, struct in_addr *source, struct in_addr *victim,
                     unsigned long seq, int sport, int dport, int flags);
int send_ip_raw( int sd, struct in_addr *source, 
		  struct in_addr *victim, unsigned char proto,
		  char *data, unsigned short datalen);

/* Decoy versions of the raw packet sending functions ... */
int send_tcp_raw_decoys( int sd, struct in_addr *victim, unsigned short sport, 
                         unsigned short dport, unsigned int seq,
                         unsigned int ack, unsigned char flags,
                         unsigned short window, char *options, int optlen,
                         char *data, unsigned short datalen);

int send_udp_raw_decoys( int sd, struct in_addr *victim, unsigned short sport, 
			 unsigned short dport, char *data, 
			 unsigned short datalen);

int send_small_fragz_decoys(int sd, struct in_addr *victim, unsigned long seq, 
                            int sport, int dport, int flags);


int send_ip_raw_decoys( int sd, struct in_addr *victim, unsigned char proto,
                        char *data, unsigned short datalen);

/* Calls pcap_open_live and spits out an error (and quits) if the call fails.
   So a valid pcap_t will always be returned. */
pcap_t *my_pcap_open_live(char *device, int snaplen, int promisc, int to_ms);

/* A simple function I wrote to help in debugging, shows the important fields
   of a TCP packet*/
int readtcppacket(char *packet, int readdata);
int readudppacket(char *packet, int readdata);
/* Convert an IP address to the device (IE ppp0 eth0) using that address */
int ipaddr2devname( char *dev, struct in_addr *addr );
/* And vice versa */
int devname2ipaddr(char *dev, struct in_addr *addr);
/* Where the above 2 functions get their info */
struct interface_info *getinterfaces(int *howmany);
inline void sethdrinclude(int sd);
int getsourceip(struct in_addr *src, struct in_addr *dst);
/* Get the source IP and interface name that a packet
   to dst should be sent to.  Interface name is dynamically
   assigned and thus should be freed */
char *getsourceif(struct in_addr *src, struct in_addr *dst);
int islocalhost(struct in_addr *addr);
int unblock_socket(int sd);
inline int Sendto(char *functionname, int sd, char *packet, int len, 
	   unsigned int flags, struct sockaddr *to, int tolen);
/* Standard swiped internet checksum routine */
unsigned short in_cksum(unsigned short *ptr,int nbytes);
/* Hex dump */
int get_link_offset(char *device);
char *readip_pcap(pcap_t *pd, unsigned int *len, long to_usec);
#ifndef HAVE_INET_ATON
in_addr_t inet_aton(register const char *, struct in_addr *);
#endif


#endif /*TCPIP_H*/





