# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-1.0.1.ebuild,v 1.1 2003/05/01 16:08:37 lordvan Exp $

IUSE=""

MY_P="${PN}-small-${PV}"
DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming"
HOMEPAGE="http://www.transgaming.com/"

SLOT="3"
KEYWORDS="~x86"
LICENSE="Aladdin" # not sure about that .. comments?

RDEPEND="virtual/x11
         >=dev-lang/python-2.0
         >=dev-python/pygtk-1.99.16
         >=x11-themes/gtk-engines-metal-2.2.0"
         # Homepage says it needs gtk2-engines .. that shoudl do ..
DEPEND="${RDEPEND}"

src_unpack () {
	if [ ! -e "${DISTDIR}/${MY_P}.tgz" ] ; then
		eerror ""
		eerror "Please download the appropriate Point2Play archive (${MY_P}.tgz)"
		eerror "from: ${HOMEPAGE} (requires a Transgaming subscription)."
		eerror ""
		eerror "The archive should be placed into ${DISTDIR}."
		eerror ""

		die "package archive (${MY_P}.tgz) not found"
	fi
	unpack "${MY_P}.tgz"
}

src_compile() {
    # nothing to compile 
    echo ""
}

src_install () {
	mv "${WORKDIR}/usr" "${D}"
	# not handling /etc for now since i'm not sure about kde/gnome directory conventions
}

