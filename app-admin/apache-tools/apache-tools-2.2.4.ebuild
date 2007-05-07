# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apache-tools/apache-tools-2.2.4.ebuild,v 1.1 2007/05/07 14:07:23 phreak Exp $

DESCRIPTION="Useful Apache tools - htdigest, htpasswd, ab, htdbm"
HOMEPAGE="http://httpd.apache.org/"
SRC_URI="mirror://apache/httpd/httpd-${PV}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-libs/apr-1*
	=dev-libs/apr-util-1*
	dev-libs/libpcre
	!<net-www/apache-2.2.4"

DEPEND="${RDEPEND}"

S="${WORKDIR}/httpd-${PV}"

src_compile() {
	cd "${S}"
	econf \
		--with-pcre=/usr || die "econf failed!"

	cd support
	emake htpasswd htdigest ab htdbm
}

src_install () {
	cd "${S}"
	dosbin support/{htdigest,htpasswd,ab,htdbm}
	dodoc CHANGES INSTALL
	doman docs/man/{htdigest.1,htpasswd.1,ab.8,htdbm.1}
}
