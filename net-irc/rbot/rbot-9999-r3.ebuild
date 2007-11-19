# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-9999-r3.ebuild,v 1.1 2007/11/19 13:56:54 flameeyes Exp $

inherit ruby gems

[[ ${PV} == "9999" ]] && inherit subversion

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="spell"

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb
	dev-ruby/tzinfo"
DEPEND=""

if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	ESVN_REPO_URI="svn://linuxbrit.co.uk/giblet/rbot/trunk"

	DEPEND="${DEPEND}
		dev-ruby/rake
		app-arch/zip"

	IUSE="${IUSE} snapshot"
else
	SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.gem"
fi

pkg_setup() {
	enewuser rbot -1 -1 /var/lib/rbot nobody
}

svn_gem_version() {
	use snapshot && \
		echo 9998.${ESVN_WC_REVISION} || \
		echo 9999
}

src_unpack() {
	[[ ${PV} == "9999" ]] || return 0
	subversion_src_unpack

	cd "${S}"
	sed -i -e "/s.version =/s:'.\+':'$(svn_gem_version)':" Rakefile \
		|| die  "Unable to fix Rakefile version."
	sed -i -e '/\$version=/s:".\+":"'$(svn_gem_version)'":' bin/rbot \
		|| die "Unable to fix rbot script version."
}

src_compile() {
	[[ ${PV} == "9999" ]] || return 0
	rake || die "Gem generation failed"
}

src_install() {
	if [[ ${PV} == "9999" ]]; then
		GEM_SRC="${S}/pkg/rbot-$(svn_gem_version).gem"
		MY_P="${PN}-$(svn_gem_version)"
	fi
	gems_src_install

	diropts -o rbot -g nobody -m 0700
	keepdir /var/lib/rbot

	newinitd "${FILESDIR}/rbot.init" rbot
	newconfd "${FILESDIR}/rbot.conf" rbot
}

pkg_postinst() {
	einfo
	elog "rbot now can be started as a normal service."
	elog "Check /etc/conf.d/rbot file for more information"
	elog "about using this feature."
	einfo
}
