# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-0.7.5-r1.ebuild,v 1.2 2004/03/21 15:41:33 mholzer Exp $

MY_PGSQL="postgresql-7.3.4"
DESCRIPTION="adds support for geographic objects to PostgreSQL"
HOMEPAGE="http://postgis.refractions.net/"
SRC_URI="http://postgis.refractions.net/${P}.tar.gz
	ftp://ftp8.us.postgresql.org/pub/pgsql/source/v7.3.4/${MY_PGSQL}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcltk python perl java ssl nls libg++"

DEPEND="~dev-db/postgresql-7.3.4
	dev-libs/proj
	>=sys-apps/sed-4*"

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
