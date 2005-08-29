# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/clearsilver/clearsilver-0.9.7.ebuild,v 1.12 2005/08/29 23:01:36 dju Exp $

inherit eutils

DESCRIPTION="Clearsilver is a fast, powerful, and language-neutral HTML template system."
HOMEPAGE="http://www.clearsilver.net/"
SRC_URI="http://www.clearsilver.net/downloads/${P}.tar.gz"

LICENSE="CS-1.0"
SLOT="0"
KEYWORDS="~amd64 ~sparc ppc x86"
IUSE="apache2 java perl python ruby zlib"

DEPEND="apache2? ( >=net-www/apache-2 )
	java? ( virtual/jdk )
	perl? ( dev-lang/perl )
	python? ( >=dev-lang/python-2.1 )
	ruby? ( dev-lang/ruby )
	zlib? ( sys-libs/zlib )"

DOCS="CS_LICENSE README README.python INSTALL"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i s/apxs/apxs2/g configure
	sed -i s,bin/httpd,bin/apache2,g configure
	epatch ${FILESDIR}/${PV}-python.patch
	epatch ${FILESDIR}/${P}-python24.patch
}

src_compile() {
	local myconf
	local jdkhome=`java-config -O`

	use apache2 && myconf="${myconf} --with-apache" \
		|| myconf="${myconf} --disable-apache"
	use java && myconf="${myconf} --with-java=${jdkhome}" \
		|| myconf="${myconf} --disable-java"
	use perl && myconf="${myconf} --with-perl" \
		|| myconf="${myconf} --disable-perl"
	use python && myconf="${myconf} --with-python" \
		|| myconf="${myconf} --disable-python"
	# ruby support disabled for now
	# use ruby && myconf="${myconf} --with-ruby" \
	myconf="${myconf} --disable-ruby"
	use zlib || myconf="${myconf} --disable-compression"
	# mono support disabled for now
	# use mono && myconf="${myconf} --with-csharp" \
	myconf="${myconf} --disable-csharp"

	econf $myconf || die "./configure failed"

	emake -j1 || die "make failed"
}

src_install () {
	cd ${S}
	sed -i s,/usr/local,/usr, scripts/document.py
	make DESTDIR=${D} install || die "make install failed"

	dodir /var/www/localhost/cgi-bin
	mv ${D}/usr/bin/static.cgi ${D}/var/www/localhost/cgi-bin/clearsilver.cgi

	dodoc ${DOCS}
}
