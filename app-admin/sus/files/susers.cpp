// Internal macros
#define		LOG_TO_SYSLOG	1
#define		LOG_FACILITY	LOG_DAEMON
#define		LOG_LEVEL	LOG_INFO

#define		WRITE_ROOT_TIMESTAMP		1
#define ROOT_TIMESTAMP_DIR /var/run/sus

#define UMASK 0022

#define		ENV_PRESERVE	"TERM=.*","TZ=.*","DISPLAY=.*",\
				"EDITOR=.*","VISUAL=.*","TAPE=.*",\
				"XAUTHORITY=.*","NIS_PATH=.*",\
				"LM_LICENSE_FILE=.*","LPDEST=.*",\
				"PRINTER=.*","MANPATH=.*",\
				"TERMINFO=.*","PS.=.*",\
				"SSH_.*=.*"

#define	PATH "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:" \
"/opt/bin"

//###################################################################
// People groups
//###################################################################
#define WHEEL_USERS  USER(ingroup=GROUP(groupname=wheel))

//###################################################################
// Now for the permissions
//###################################################################

// members of group "wheel" can run anything, anywhere
WHEEL_USERS : ANY_COMMAND
