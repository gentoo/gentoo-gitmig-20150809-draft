# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jmax/jmax-4.1.0.ebuild,v 1.3 2004/07/22 15:07:01 axxo Exp $

IUSE="alsa jack doc"

inherit eutils libtool

DESCRIPTION="jMax is a visual programming environment for building interactive real-time music and multimedia applications."
HOMEPAGE="http://freesoftware.ircam.fr/rubrique.php3?id_rubrique=2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	 mirror://gentoo/jmax-m4-1.0.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
#-amd64, -sparc: 4.1.0: fts/linux.c has only code for ppc and ix86

KEYWORDS="x86 -amd64 -sparc"

RDEPEND=">=virtual/jre-1.4
	jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	doc? ( app-doc/doxygen )
	sys-devel/autoconf"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	unpack jmax-m4-1.0.tar.bz2
	epatch ${FILESDIR}/${P}-otherArch.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
	# fixed 57691
	epatch ${FILESDIR}/${P}-fix-java-check.patch

	export WANT_AUTOMAKE=1.6
	export WANT_AUTOCONF=2.5
	touch INSTALL NEWS
	aclocal -I m4 || die
	automake # this will fail because of bad upstream Makefile.am
	autoconf || die

	elibtoolize
}

src_compile() {
	econf || die "econf failed"
	# -j2 fails.  See bug #47978
	emake -j1 || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog JMAX-VERSION LICENCE.fr LICENSE LISEZMOI README
}



pkg_postinst() {
	echo
	einfo "To get started, have a look at the tutorials"
	einfo "in /usr/share/jmax/tutorials/basics"
	echo
}
