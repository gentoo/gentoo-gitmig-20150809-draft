# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-0.31_pre2-r1.ebuild,v 1.1 2004/04/09 22:39:57 seemant Exp $

IUSE="nls oggvorbis flac gtk2"

MY_PV=${PV/1_pre/0.}
MY_P=${PN}-${MY_PV}
DSD_PATCH=${MY_P}-dsd2.patch
S=${WORKDIR}/${MY_P}
DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	gtk2? http://www.reactivated.net/patches/easytag-0.30/${DSD_PATCH}"
HOMEPAGE="http://easytag.sourceforge.net/"

RDEPEND=">=media-libs/id3lib-3.8.2
	gtk2? ( =x11-libs/gtk+-2.4* )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	flac? ( >=media-libs/flac-1.1.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7*
	>=sys-devel/autoconf-2.5*
	>=sys-apps/sed-4.0.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	if [ `use gtk2` ] ; then
		epatch ${DISTDIR}/${DSD_PATCH}
		export WANT_AUTOMAKE=1.7
		export WANT_AUTOCONF=2.5
		ebegin "Remaking configure script (be patient)"
		autoreconf &>/dev/null
		eend $?
	else
		epatch ${FILESDIR}/${MY_P}-fix-configure.patch
		export WANT_AUTOCONF=2.5
		autoconf
	fi
}

src_compile() {
	local myconf

	econf \
	`use_enable oggvorbis ogg` \
	`use_enable nls` \
	`use_enable flac` \
	${myconf} || die "econf failed"
	emake || die
}

src_install() {
	einstall \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die

	dodoc ChangeLog COPYING NEWS README TODO THANKS USERS-GUIDE
}

pkg_postinst() {
	if [ `use gtk2` ] ; then
		einfo "You merged with the \"gtk2\" USE flag set"
		ewarn "GTK+ 2 support for this program is still experimental"
		ewarn "Please report bugs to http://bugs.gentoo.org"
	fi
}
