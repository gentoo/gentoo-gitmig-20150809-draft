# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xview/xview-3.2.ebuild,v 1.4 2004/02/17 08:06:47 mr_bones_ Exp $

DESCRIPTION="The X Window-System-based Visual/Integrated Environment for Workstations"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/libs/X/xview/"

PN="${P}p1.4"

# This is our compound patch derived from debian. We use it because:
#  * xview is a contribution made to Sun Microsystems (?) to the X community, but
#    fixes for it don't appear to be around other than in the other free distributions.
#  * It does little harm, only some defaults are changed which we can redefine anyway
SRC_PATCH="${PN/-/_}-16.diff"

# We use the xview tarball available from the X organization, but xfree86 appears
# to be up and available more often so we use that (it's their primary mirror).
SRC_URI="http://www.ibiblio.org/pub/Linux/libs/X/xview/${PN}.src.tar.gz
		 http://ftp.debian.org/pool/main/x/xview/${SRC_PATCH}.gz"
S=${WORKDIR}/${PN}
LICENSE="sun-openlook"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc x86"
DEPEND="virtual/x11"

src_unpack() {
	unpack $A
	cd $S
	epatch ../${SRC_PATCH}
}

src_compile() {
	# Create the makefile
	imake -DUseInstalled -I${S}/config -I/usr/X11R6/lib/X11/config

	# This is crazy and I know it, but wait till you read the code in 
	# Build-LinuxXView.bash.
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash libs
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash clients
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash contrib
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash olvwm
}

src_install() {
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instlibs
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instclients
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instcontrib
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instolvwm
	cd ${D}/usr
	ln -s X11R6 openwin

	# The rest of the docs is already installed 
	cd ${S}/doc
	dodoc README xview-info olgx_api.txt olgx_api.ps sel_api.txt dnd_api.txt whats_new.ps
	dodoc bugform
	dodoc config/usenixws/paper.ps
	rm -rf ${D}/usr/X11R6/share/doc/xview && rm -rf ${D}/usr/X11R6/share/doc
}
