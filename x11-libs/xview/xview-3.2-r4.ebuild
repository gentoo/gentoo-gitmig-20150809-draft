# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xview/xview-3.2-r4.ebuild,v 1.1 2005/08/14 00:55:23 ribosome Exp $

inherit eutils

DESCRIPTION="The X Window-System-based Visual/Integrated Environment for Workstations"
HOMEPAGE="http://physionet.caregroup.harvard.edu/physiotools/xview/"

MY_PN="${P}p1.4-18c"

# This is our compound patch derived from debian. We use it because:
#  * xview is a contribution made by Sun Microsystems (?) to the X community, but
#    fixes for it don't appear to be around other than in the other free distributions.
#  * It does little harm, only some defaults are changed which we can redefine anyway
#SRC_PATCH="${PN}_3.2p1.4-16woody2.diff"

# We use the xview tarball available from the X organization, but xfree86 appears
# to be up and available more often so we use that (it's their primary mirror).
SRC_URI="http://physionet.caregroup.harvard.edu/physiotools/xview/${MY_PN}.tar.gz"
		 #mirror://debian/pool/main/x/xview/${SRC_PATCH}.gz"
S=${WORKDIR}/${MY_PN}
LICENSE="sun-openlook"
SLOT="0"
KEYWORDS="-alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack $A
	cd $S
	epatch ${FILESDIR}/CAN-2005-0076.patch
	# Do not build xgettext and msgfmt since they are provided by the gettext
	# package. Using the programs provided by xview breaks many packages
	# including vim, grep and binutils.
	sed -e 's/MSG_UTIL = xgettext msgfmt/#MSG_UTIL = xgettext msgfmt/' \
		-i util/Imakefile || die
}

src_compile() {
	# Create the makefile
	imake -DUseInstalled -I${S}/config -I/usr/X11R6/lib/X11/config \
		|| die "imake failed"

	# This is crazy and I know it, but wait till you read the code in 
	# Build-LinuxXView.bash.
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash libs \
		|| die "building libs failed"
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash clients \
		|| die "building clients failed"
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash contrib \
		|| die "building contrib failed"
	OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash olvwm \
		|| die "building olvwm failed"
}

src_install() {
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instlibs \
		|| die "installing libs failed"
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instclients \
		|| die "installing clients failed"
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instcontrib \
		|| die "installing contrib failed"
	DESTDIR=${D} OPENWINHOME=/usr/X11R6 bash Build-LinuxXView.bash instolvwm \
		|| die "installing olvwm failed"
	cd ${D}/usr
	ln -s X11R6 openwin

	# The rest of the docs is already installed 
	cd ${S}/doc
	dodoc README xview-info olgx_api.txt olgx_api.ps sel_api.txt \
		dnd_api.txt whats_new.ps bugform config/usenixws/paper.ps
	rm -rf ${D}/usr/X11R6/share/doc/xview && rm -rf ${D}/usr/X11R6/share/doc
}
