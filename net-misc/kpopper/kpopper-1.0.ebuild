# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kpopper/kpopper-1.0.ebuild,v 1.1 2002/04/10 12:25:02 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S="${WORKDIR}/popper-1.0"
DESCRIPTION="A very simple, easy-to-use and functional network messager."
SRC_URI="http://prdownloads.sourceforge.net/kpopper/popper-1.0.tar.gz"
HOMEPAGE="http://kpopper.sourceforge.net/"
SLOT="0"

NEWDEPEND="$DEPEND >=net-fs/samba-2.2"

