# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/twiki/twiki-4.0.2.ebuild,v 1.1 2006/04/20 14:37:05 rl03 Exp $

inherit webapp eutils versionator

MY_PN="TWiki"

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://twiki.org/p/pub/Codev/Release/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="apache2"

S=${WORKDIR}

RDEPEND=">=dev-lang/perl-5.8
		>=app-text/rcs-5.7
		sys-apps/diffutils
		dev-perl/Algorithm-Diff
		virtual/perl-CGI
		perl-core/File-Spec
		dev-perl/Text-Diff
		perl-core/Time-Local
		dev-perl/CGI-Session
		perl-core/digest-base
		dev-perl/Digest-SHA1
		dev-perl/locale-maketext-lexicon
		virtual/perl-libnet
		dev-perl/URI
		virtual/cron
		apache2? ( >=net-www/apache-2.0.54 )
		!apache2? ( =net-www/apache-1* )"

src_unpack() {
	unpack ${A}
	cd ${S}

	mv ${S}/bin/LocalLib.cfg.txt ${S}/bin/LocalLib.cfg
	mv ${S}/lib/LocalSite.cfg.txt ${S}/lib/LocalSite.cfg
	# change web user to apache
	cd ${S}/lib/TWiki
	find . -name '*,v' -exec sed -i 's|nobody:|apache:|g' '{}' ';'
}

src_install() {
	webapp_src_preinst

	cp -r . ${D}/${MY_HTDOCSDIR}

	dodoc readme.txt
	dohtml T*.html

	for file in $(find data pub) lib/LocalSite.cfg; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	for a in bin/setlib.cfg bin/LocalLib.cfg lib/TWiki.cfg lib/LocalSite.cfg; do
		webapp_configfile ${MY_HTDOCSDIR}/${a}
	done
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade-en.txt

	webapp_src_install
}

pkg_postinst() {
	ewarn
	ewarn "If you are upgrading from an older version of TWiki, back up your"
	ewarn "data/ and pub/ directories and any local changes before upgrading!"
	ewarn
	ewarn "You are _strongly_ encouraged to to read the upgrade guide:"
	ewarn "http://twiki.org/cgi-bin/view/TWiki/TWikiDocumentation"
	ewarn
	einfo "webapp-config will not be run automatically"
	einfo
	# webapp_pkg_postinst
}
