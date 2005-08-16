# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/myodbc/myodbc-3.51.11.ebuild,v 1.4 2005/08/16 19:43:21 vivo Exp $

MY_PN="MyODBC"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="ODBC driver for MySQL"
HOMEPAGE="http://www.mysql.com/products/myodbc/"
SRC_URI="mirror://mysql/Downloads/MyODBC3/${MY_P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc static"
RDEPEND=">=dev-db/mysql-4 dev-db/unixODBC sys-devel/m4"
# perl is required for building docs
DEPEND="${RDEPEND} doc? ( dev-lang/perl )"
S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf="--enable-static"
	use static \
		&& myconf="${myconf} --disable-shared" \
		|| myconf="${myconf} --enable-shared"

	myconf="${myconf} `use_with doc docs` `use_with debug`"

	econf \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/myodbc \
		--localstatedir=/var/lib/myodbc \
		--with-mysql-libs=/usr/lib/mysql \
		--with-mysql-includes=/usr/include/mysql \
		--with-odbc-ini=/etc/unixODBC/odbc.ini \
		--with-unixODBC=/usr \
		--disable-test \
		--without-samples \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	into /usr
	einstall \
		libexecdir=${D}/usr/sbin \
		sysconfdir=${D}/etc/myodbc \
		localstatedir=${D}/var/lib/myodbc
	dodoc INSTALL RELEASE-NOTES README
}

pkg_config() {
	[ "${ROOT}" != "/" ] && \
	die "Sorry, non-standard \$ROOT setting is not supported :-("

	for i in odbc.ini odbcinst.ini; do
		einfo "Building $i"
		/usr/bin/m4 -D__PN__=${PN} -D__PF__=${PF} ${FILESDIR}/${i}.m4 >${T}/${i}
	done;

	local msg='MySQL ODBC driver'
	local drivers=$(/usr/bin/odbcinst -q -d)
	if echo $drivers | grep -vq "^\[${PN}\]$" ; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -d -f ${T}/odbcinst.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi

	local sources=$(/usr/bin/odbcinst -q -s)
	msg='sample MySQL ODBC DSN'
	if echo $sources | grep -vq "^\[${PN}-test\]$"; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -s -l -f ${T}/odbc.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi
}

pkg_postinst() {
	einfo "If this is a new install, please run the following command"
	einfo "to configure the MySQL ODBC drivers and sources:"
	einfo "ebuild ${PORTDIR}/${CATEGORY}/${PN}/${PF}.ebuild config"
}
