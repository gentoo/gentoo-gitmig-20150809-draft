# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-0.30c.ebuild,v 1.2 2004/01/17 03:32:23 darkspecter Exp $

IUSE="nls oggvorbis"

inherit eutils

MY_PV=${PV/%[a-zA-Z]/}
MY_P=${PN}-${MY_PV}
MY_P2=${MY_P/-/_}
MY_P2=${MY_P2/./}

S=${WORKDIR}/${MY_P}
DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/easytag/${MY_P}.tar.bz2
	mirror://sourceforge/easytag/patch_${MY_P2}_${MY_PV/./}a.diff
	mirror://sourceforge/easytag/patch_${MY_P2}a_${MY_PV/./}b.diff
	mirror://sourceforge/easytag/patch_${MY_P2}b_${PV/./}.diff"

RDEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/id3lib-3.8.2
	media-libs/flac
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND=">=sys-apps/sed-4.0.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~mips ~hppa ~ia64 ~amd64"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${DISTDIR}/patch_${MY_P2}_${MY_PV/./}a.diff
	epatch ${DISTDIR}/patch_${MY_P2}a_${MY_PV/./}b.diff
	epatch ${DISTDIR}/patch_${MY_P2}b_${PV/./}.diff
}


src_compile() {
	local myconf

	#use_enable breaks this
	use oggvorbis || myconf="${myconf} --disable-ogg"

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die

	dodoc ChangeLog COPYING NEWS README TODO THANKS USERS-GUIDE
}
