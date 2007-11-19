# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-9999-r4.ebuild,v 1.1 2007/11/19 16:42:46 flameeyes Exp $

inherit ruby gems eutils

[[ ${PV} == "9999" ]] && inherit subversion

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="spell aspell timezone"
ILINGUAS="zh ru nl de fr it en ja"

for lang in $ILINGUAS; do
	IUSE="${IUSE} linguas_${lang}"
done

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb
	timezone? ( dev-ruby/tzinfo )
	spell? (
		aspell? ( app-text/aspell )
		!aspell? ( app-text/ispell )
	)"
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
	else
		MY_P="${P}"
	fi
	gems_src_install

	diropts -o rbot -g nobody -m 0700
	keepdir /var/lib/rbot

	newinitd "${FILESDIR}/rbot.init" rbot
	newconfd "${FILESDIR}/rbot.conf" rbot

	local rbot_datadir="${D}/${GEMSDIR}"/gems/${MY_P}/data/rbot

	disable_rbot_plugin() {
		mv "${rbot_datadir}"/plugins/$1.rb{,.disabled}
	}

	if ! use spell; then
		disable_rbot_plugin spell || die "Unable to disable spell plugin"
	elif use aspell; then
		# This is not officially supported, but as ispell is quite a
		# bad piece of code, at least give an opportunity to use
		# something that works a bit better.
		sed -i -e 's:ispell:ispell-aspell:' \
			"${rbot_datadir}"/plugins/spell.rb \
			|| die "Unable to replace ispell with aspell."
	fi

	# This is unfortunately pretty manual at the moment, but it's just
	# to avoid having to run special scripts to package new versions
	# of rbot. The default if new languages are added that are not
	# considered for an opt-out here is to install them, so you just
	# need to add them later.
	strip-linguas ${ILINGUAS}
	if [[ -n ${LINGUAS} ]]; then
		# As the the language name used by the rbot data files does
		# not correspond to the ISO codes we usually use for LINGUAS,
		# the following list of local varables will work as a
		# dictionary to get the name used by rbot from the ISO code.
		local lang_rbot_zh="traditional_chinese"
		local lang_rbot_ru="russian"
		local lang_rbot_nl="dutch"
		local lang_rbot_de="german"
		local lang_rbot_fr="french"
		local lang_rbot_it="italian"
		local lang_rbot_en="english"
		local lang_rbot_ja="japanese"

		for lang in ${ILINGUAS}; do
			use linguas_${lang} && continue

			lang="lang_rbot_${lang}"
			lang_rbot=${!lang}

			rm \
				${rbot_datadir}/languages/${lang_rbot}.lang \
				${rbot_datadir}/templates/lart/larts-${lang_rbot} \
				${rbot_datadir}/templates/lart/praises-${lang_rbot} \
				${rbot_datadir}/templates/salut/salut-${lang_rbot}
		done
	fi
}

pkg_postinst() {
	einfo
	elog "rbot now can be started as a normal service."
	elog "Check /etc/conf.d/rbot file for more information about this feature."
	einfo
}
