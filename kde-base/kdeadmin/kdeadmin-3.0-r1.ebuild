# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.0-r1.ebuild,v 1.1 2002/05/10 12:07:56 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die

CHILDREN="
~app-admin/kcmlinuz-0.0.0
~app-admin/kcron-3.0
~app-arch/kdat-2.0.1
~app-arch/kpackage-3.0
~app-admin/ksysv-1.3.8
~app-admin/kuser-1.0
~app-admin/kwuftpd-0.2.0
~app-admin/lilo-config-0.0.0
~app-admin/secpolicy-0.0.1"

PN=kdeadmin
PV=3.0
P=$PN-$PV

inherit kde-dist kde-parent

DESCRIPTION="${DESCRIPTION}Administration"



