# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/skunkweb/skunkweb-3.4.3.ebuild,v 1.5 2007/05/12 03:52:33 chtekk Exp $

inherit eutils apache-module

DESCRIPTION="robust Python web application server"
HOMEPAGE="http://skunkweb.sourceforge.net/"
SRC_URI="mirror://sourceforge/skunkweb/${P}.tar.gz"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.4
		app-admin/sudo"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="${S}/SkunkWeb/mod_skunkweb/.libs/mod_skunkweb.so"

APACHE2_MOD_DEFINE="SKUNKWEB"

APACHE2_MOD_CONF="100_mod_skunkweb"

need_apache

pkg_setup() {
	enewgroup skunkweb
	enewuser skunkweb -1 -1 /usr/share/skunkweb skunkweb
}

src_compile() {
	local apxs="${APXS2}"

	econf \
		--with-user=skunkweb \
		--with-group=skunkweb \
		--localstatedir=/var/lib/skunkweb \
		--bindir=/usr/bin \
		--libdir=/usr/$(get_libdir)/skunkweb \
		--sysconfdir=/etc/skunkweb \
		--prefix=/usr/share/skunkweb \
		--with-cache=/var/lib/skunkweb/cache \
		--with-docdir=/usr/share/doc/${P} \
		--with-logdir=/var/log/skunkweb \
		--with-python=/usr/bin/python \
		--with-apxs=${apxs} || die "configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} APXSFLAGS="-c" install || die "make install failed"
	apache-module_src_install

	# dirs --------------------------------------------------------------
	keepdir /var/{lib,log}/${PN}
	keepdir /var/lib/${PN}/run
	chown -R skunkweb:skunkweb ${D}/var/{lib,log}/${PN}
	# scripts------------------------------------------------------------
	newinitd ${FILESDIR}/skunkweb-init skunkweb
	exeinto /etc/cron.daily
	newexe ${FILESDIR}/skunkweb-cron-cache_cleaner skunkweb-cache_cleaner
	# docs --------------------------------------------------------------
	dodoc README ChangeLog NEWS HACKING ACKS INSTALL
	if use doc; then
		dodir /usr/share/doc/${PF}
		cp docs/paper-letter/*.pdf ${D}/usr/share/doc/${PF}
		ewarn "Some docs are still in upstream cvs (i.e.: formlib, pydo2)"
	fi
}
