# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.3-r1.ebuild,v 1.17 2004/07/15 02:40:32 agriffis Exp $

inherit eutils

IUSE="nls build"

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="http://www.gnu.org/software/texinfo/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/texinfo/${P}.tar.gz
	ftp://alpha.gnu.org/pub/gnu/texinfo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha hppa mips"

DEPEND=">=sys-apps/portage-2.0.47-r10
	!build? ( >=sys-libs/ncurses-5.2-r2
	          >=sys-apps/sed-4.0.5
	          nls? ( sys-devel/gettext ) )"

src_unpack() {
	unpack ${A}

	cd ${S}/doc
	# Get the texinfo info page to have a proper name of texinfo.info
	sed -i 's:setfilename texinfo:setfilename texinfo.info:' texinfo.txi

	sed -i \
		-e 's:INFO_DEPS = texinfo:INFO_DEPS = texinfo.info:' \
		-e 's:texinfo\::texinfo.info\::' \
		Makefile.in

	cd ${S}/util
	epatch ${FILESDIR}/install-info.patch
}

src_compile() {
	local myconf=""
	if ! use nls || use build ; then
		myconf="--disable-nls"
	fi

	export WANT_AUTOMAKE_1_6=1
	econf ${myconf} || die

	emake || die
}

src_install() {
	if use build ; then
		mv util/ginstall-info util/install-info
		dobin makeinfo/makeinfo util/{install-info,texi2dvi,texindex}
	else
		make DESTDIR=${D} \
			infodir=/usr/share/info \
			install || die

		exeinto /usr/sbin
		doexe ${FILESDIR}/mkinfodir

		if [ ! -f ${D}/usr/share/info/texinfo.info ] ; then
			die "Could not install texinfo.info!!!"
		fi

		dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO
		docinto info
		dodoc info/README
		docinto makeinfo
		dodoc makeinfo/README
	fi
}
