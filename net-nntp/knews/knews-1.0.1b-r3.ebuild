# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/knews/knews-1.0.1b-r3.ebuild,v 1.1 2010/03/12 11:37:09 ssuominen Exp $

EAPI=2
inherit eutils

MY_P=${PN}-1.0b.1

DESCRIPTION="A threaded newsreader for X."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="xface jpeg"

S=${WORKDIR}/${MY_P}

RDEPEND="x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt
	jpeg? ( media-libs/jpeg:0 )
	xface? ( >=media-libs/compface-1.4 )
	virtual/mta"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-misc/gccmakedep
	x11-misc/imake
	=sys-apps/sed-4*"

src_prepare() {
	epatch "${WORKDIR}"/${MY_P}-gentoo.diff

	# http://bugs.gentoo.org/show_bug.cgi?id=309003
	# use png && sed -i "s:\(#define HAVE_PNG\).*:\1\t1:" configure.h
	use jpeg && sed -i "s:\(#define HAVE_JPEG\).*:\1\t1:" configure.h
	use xface && sed -i "s:\(#define HAVE_COMPFACE\).*:\1\t1:" configure.h

	sed -i \
		-e "s:\(#define HAVE_XPM\).*:\1\t1:" \
		-e "s:\(#define DEFAULT_EDIT_COMMAND\).*:\1 \"${EDITOR} %s\":" \
		configure.h
}

src_compile() {
	xmkmf -a || die
	emake CDEBUGFLAGS="${CFLAGS}" all || die
}

src_install() {
	emake -j1 \
		DESTDIR="${D}" \
		DOCHTMLDIR=/usr/share/doc/${PF} \
		MANPATH=/usr/share/man \
		MANSUFFIX=1 \
		install install.man || die

	rm -rf "${D}"/{etc/X11,usr/lib}

	insinto /usr/share/X11/app-defaults
	newins src/Knews.ad Knews || die

	dodir /etc/knews
	touch "${D}"/etc/knews/mailname "${D}"/etc/knews/newsserver

	dodoc Changes README
}

pkg_postinst() {
	einfo "Please be sure to set your local domain in"
	einfo "    /etc/knews/mailname"
	einfo
	einfo "And please set your news server in"
	einfo "    /etc/knews/newsserver"
}
