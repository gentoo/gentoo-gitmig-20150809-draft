# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hercules/hercules-3.07.ebuild,v 1.1 2010/08/30 04:25:33 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Hercules System/370, ESA/390 and zArchitecture Mainframe Emulator"
HOMEPAGE="http://www.hercules-390.org/"
SRC_URI="http://www.hercules-390.org/${P}.tar.gz"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="custom-cflags"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:@modexecdir@:$(libdir)/$(PACKAGE):' \
		-e '/^AM_CPPFLAGS/s:=:= -DMODULESDIR=\\"$(modexecdir)\\" :' \
		-e 's:ltdl.lo::' \
		-e '/^libherc_la_LIBADD/s:=:= -lltdl :' \
		$(find -name Makefile.in)
	sed -i '/MODULESDIR/d' config.h.in
}

src_compile() {
	use custom-cflags || strip-flags
	econf \
		--enable-cckd-bzip2 \
		--enable-het-bzip2 \
		--enable-setuid-hercifc \
		--enable-custom="Gentoo ${PF}.ebuild" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto /usr/share/hercules
	doins hercules.cnf
	dodoc README.* RELEASE.NOTES CHANGES
	dohtml -r html
}
