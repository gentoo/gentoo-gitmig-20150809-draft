# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.0.2.ebuild,v 1.1 2004/09/22 20:27:41 latexer Exp $

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-1.0.2
	dev-libs/apr
	=net-www/apache-2*
	>=dev-dotnet/xsp-1.0.2"

RDEPEND=""

src_compile() {
	econf \
		--libexecdir=/usr/lib/apache2-extramodules \
		--with-apxs=/usr/sbin/apxs2 \
		--with-apr-config=/usr/bin/apr-config || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	insinto /usr/lib/apache2-extramodules
	doins src/.libs/mod_mono.so.0.0.0

	insinto /etc/apache2/conf/modules.d
	newins ${FILESDIR}/${P}-70_mod_mono.conf 70_mod_mono.conf

	doman man/mod_mono.8

	einfo "To view the samples, uncomment the commented blocks in"
	einfo "/etc/apache2/conf/modules.d/70_mod_mono.conf"
	einfo
	einfo "Edit /etc/conf.d/apache2 and add \"-D MONO\" to APACHE2_OPTS"
}

