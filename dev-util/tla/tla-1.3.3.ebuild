# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tla/tla-1.3.3.ebuild,v 1.2 2006/01/07 01:56:43 arj Exp $

S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="Revision control system ideal for widely distributed development"
SRC_URI="mirror://gnu/gnu-arch/${P}.tar.gz
	http://dev.gentoo.org/~arj/tla.1-2.gz"
HOMEPAGE="http://savannah.gnu.org/projects/gnu-arch http://wiki.gnuarch.org/ http://arch.quackerhead.com/~lord/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~hppa ~sparc ~amd64"
IUSE=""

DEPEND="sys-apps/coreutils
	sys-apps/diffutils
	sys-devel/patch
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make"

src_unpack() {
	unpack ${P}.tar.gz
	unpack tla.1-2.gz
	mkdir "${S}"
	cd "${WORKDIR}/${P}"
	sed -i 's:/home/lord/{install}:/usr:g' "${WORKDIR}/${P}/src/tla/=gpg-check.awk"
}

src_compile() {
	../configure \
		--prefix="/usr" \
		--with-posix-shell="/bin/bash"	|| die "configure failed"
	# parallel make may cause problems with this package
	make || die "make failed"
}

src_install () {
	make install prefix="${D}/usr" \
		|| die "make install failed"

	cd ${S}/../..
	dodoc =README
	cd ${S}/..
	dodoc COPYING
	dodoc ChangeLog
	cd docs-tla
	docinto ps
	dodoc ps/*.ps
	docinto html
	dohtml -r html/
	cd ${WORKDIR}
	doman tla.1

	chmod 755 "${WORKDIR}/${P}/src/tla/=gpg-check.awk"
	cp -pPR "${WORKDIR}/${P}/src/tla/=gpg-check.awk" "${D}/usr/bin/tla-gpg-check.awk"
}
