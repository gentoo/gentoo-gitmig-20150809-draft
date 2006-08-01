# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-0.7.5-r2.ebuild,v 1.8 2006/08/01 00:14:18 chtekk Exp $

MY_PGSQL="postgresql-7.3.6"
DESCRIPTION="adds support for geographic objects to PostgreSQL"
HOMEPAGE="http://postgis.refractions.net/"
SRC_URI="http://postgis.refractions.net/${P}.tar.gz
	mirror://postgresql/source/v7.3.6/${MY_PGSQL}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="tcltk python perl java ssl nls libg++"

DEPEND="=dev-db/postgresql-7.3*
	sci-libs/proj
	>=sys-apps/sed-4"

src_unpack() {
	unpack "${MY_PGSQL}.tar.gz"
	cd ${MY_PGSQL}/contrib
	unpack "${P}.tar.gz"
	cd "${P}"
	sed -i -e "s:USE_PROJ=0:USE_PROJ=1:g" \
		-e "s:PROJ_DIR=/usr/local:PROJ_DIR=/usr:g" \
		Makefile
}

src_compile() {
	local myconf
	cd "${WORKDIR}/${MY_PGSQL}"
	use tcltk && myconf="--with-tcl"
	use python && myconf="${myconf} --with-python"
	use perl && myconf="${myconf} --with-perl"
	use java && myconf="${myconf} --with-java"
	use ssl && myconf="${myconf} --with-ssl"
	use nls && myconf="${myconf} --enable-locale --enable-nls --enable-multibyte"
	use libg++ && myconf="${myconf} --with-CXX"

	use ppc && CFLAGS="-pipe-fsigned-char"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${MY_PGSQL}-r1 \
		--libdir=/usr/lib \
		--enable-syslog \
		--enable-depend \
		--with-gnu-ld \
		--with-pam \
		--with-maxbackends=1024 \
		${myconf} || die

	cd contrib/${P}

	make || die
}

src_install() {
	cd ${WORKDIR}/${MY_PGSQL}/contrib/${P}

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${MY_PGSQL} \
		libdir=${D}/usr/lib/postgresql \
		install || die

	dodoc CHANGES COPYING CREDITS TODO
}
