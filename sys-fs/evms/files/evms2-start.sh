# /lib/rcscripts/addons/evms-start.sh:  Setup evms volumes at boot
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evms/files/evms2-start.sh,v 1.1 2005/05/27 03:07:46 vapier Exp $

if [[ -z ${CDBOOT} ]] ; then
	ebegin "Activating EVMS"
	evms_activate
	retval=$?
	eend ${retval}
fi
