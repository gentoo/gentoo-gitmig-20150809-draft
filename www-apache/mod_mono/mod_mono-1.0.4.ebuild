# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.0.4.ebuild,v 1.2 2004/11/13 00:14:11 latexer Exp $

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-${PV}
	=net-www/apache-2*
	>=dev-dotnet/xsp-${PV}"

RDEPEND=""

src_compile() {
	econf \
		--libexecdir=/usr/lib/apache2-extramodules \
		--with-apxs=/usr/sbin/apxs2 \
		--with-apr-config=/usr/bin/apr-config || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe src/.libs/mod_mono.so.0.0.0

	dosym /usr/lib/apache2-extramodules/mod_mono.so.0.0.0 \
		/usr/lib/apache2-extramodules/mod_mono.so
	dosym /usr/lib/apache2-extramodules/mod_mono.so.0.0.0 \
		/usr/lib/apache2-extramodules/mod_mono.so.0

	insinto /etc/apache2/conf/modules.d
	newins ${FILESDIR}/${PN}-1.0.2-70_mod_mono.conf 70_mod_mono.conf

	doman man/mod_mono.8

	einfo "To view the samples, uncomment the commented blocks in"
	einfo "/etc/apache2/conf/modules.d/70_mod_mono.conf"
	einfo
	einfo "Edit /etc/conf.d/apache2 and add \"-D MONO\" to APACHE2_OPTS"
}

