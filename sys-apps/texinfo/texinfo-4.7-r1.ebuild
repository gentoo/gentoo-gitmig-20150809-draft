# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.7-r1.ebuild,v 1.4 2004/10/29 02:28:12 vapier Exp $

inherit flag-o-matic gnuconfig eutils

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="http://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 ~sparc x86"
IUSE="nls build static"

RDEPEND="virtual/libc
	!build? ( >=sys-libs/ncurses-5.2-r2 )"
DEPEND="${RDEPEND}
	!build? (
		>=sys-apps/sed-4.0.5
		nls? ( sys-devel/gettext )
	)"

src_unpack() {
	unpack ${A}

	cd ${S}/doc
	# Get the texinfo info page to have a proper name of texinfo.info
	sed -i 's:setfilename texinfo:setfilename texinfo.info:' texinfo.txi

	sed -i \
		-e 's:INFO_DEPS = texinfo:INFO_DEPS = texinfo.info:' \
		-e 's:texinfo\::texinfo.info\::' \
		Makefile.in
	# update config.sub/config.guess for newer arches.
	gnuconfig_update

	# patch to fix groff build against 4.7. See also bug #57690 and
	# http://lists.gnu.org/archive/html/bug-texinfo/2004-07/msg00002.html
	# -- avenj@gentoo.org 22 Jul 04
	cd ${S}/makeinfo && epatch ${FILESDIR}/makeinfo.patch
}

src_compile() {
	local myconf=
	if ! use nls || use build ; then
		myconf="--disable-nls"
	fi

	use static && append-ldflags -static

	export WANT_AUTOMAKE=1.6
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

		dodoc AUTHORS ChangeLog INTRODUCTION NEWS README TODO
		docinto info
		dodoc info/README
		docinto makeinfo
		dodoc makeinfo/README
	fi
}
