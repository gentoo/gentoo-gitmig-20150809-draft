divert(-1)
#
# Copyright (c) 1998, 1999 Sendmail, Inc. and its suppliers.
#	All rights reserved.
# Copyright (c) 1983 Eric P. Allman.  All rights reserved.
# Copyright (c) 1988, 1993
#	The Regents of the University of California.  All rights reserved.
#
# By using this file, you agree to the terms and conditions set
# forth in the LICENSE file which can be found at the top level of
# the sendmail distribution.
#
#

#
#  This is a generic configuration file for Linux.
#  It has support for local and SMTP mail only.  If you want to
#  customize it, copy it to a name appropriate for your environment
#  and do the modifications there.
#

divert(0)dnl
include(`/usr/share/sendmail-cf/m4/cf.m4')dnl
VERSIONID(`$Id: sendmail-procmail.mc,v 1.1 2003/04/24 21:18:58 avenj Exp $')dnl
OSTYPE(linux)dnl
DOMAIN(generic)dnl
FEATURE(`smrsh',`/usr/sbin/smrsh')dnl
FEATURE(`local_lmtp',`/usr/sbin/mail.local')dnl
FEATURE(`local_procmail')dnl
MAILER(local)dnl
MAILER(smtp)dnl
MAILER(procmail)dnl
