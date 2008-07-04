# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.11_rc1.ebuild,v 1.2 2008/07/04 08:51:25 opfer Exp $

inherit ruby eutils

[[ ${PV} == *"9999" ]] && inherit git

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://ruby-rbot.org/"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="spell aspell timezone translator shorturl dict figlet
	fortune cal host toilet hunspell"
ILINGUAS="zh_CN zh_TW ru nl de fr it ja"

for lang in $ILINGUAS; do
	IUSE="${IUSE} linguas_${lang}"
done

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb
	timezone? ( dev-ruby/tzinfo )
	spell? (
		aspell? ( app-text/aspell )
		!aspell? (
			hunspell? ( app-text/hunspell )
			!hunspell? ( app-text/ispell )
		)
	)
	translator? ( dev-ruby/mechanize )
	shorturl? ( dev-ruby/shorturl )
	dict? ( dev-ruby/ruby-dict )
	figlet? ( app-misc/figlet )
	toilet? ( app-misc/toilet )
	fortune? ( games-misc/fortune-mod )
	cal? ( || ( sys-apps/util-linux sys-freebsd/freebsd-ubin ) )
	host? ( net-dns/bind-tools )"

if [[ ${PV} == *"9999" ]]; then
	SRC_URI=""
	EGIT_REPO_URI="git://ruby-rbot.org/rbot.git"
else
	MY_P="${P/_/-}"
	S="${WORKDIR}/${P%_*}"
	SRC_URI="http://ruby-rbot.org/download/${MY_P}-no-mo.tgz"
fi

pkg_setup() {
	enewuser rbot -1 -1 /var/lib/rbot nobody
}

src_unpack() {
	if [[ ${PV} == *"9999" ]]; then
		git_src_unpack

		cd "${S}"
		sed -i -e '/\$version=/s:".\+":"'${PV}'":' bin/rbot \
			|| die "Unable to fix rbot script version."
	else
		unpack ${A}
	fi
}

src_compile() {
	disable_rbot_plugin() {
		mv "${S}"/data/rbot/plugins/$1.rb{,.disabled}
	}
	use_rbot_plugin() {
		use $1 && return
		disable_rbot_plugin "$2"
	}
	rbot_conf() {
		echo "$1: $2" >> "${T}"/rbot.conf
	}
	use_rbot_conf_path() {
		use "$1" \
			&& rbot_conf "$2" "$3" \
			|| rbot_conf "$2" /bin/false
	}

	local spell_program="/usr/bin/ispell"
	if use !spell; then
		disable_rbot_plugin spell
		spell_program="/bin/false"
	elif use aspell; then
		spell_program="/usr/bin/ispell-aspell"
	elif use hunspell; then
		spell_program="/usr/bin/hunspell -i"
	fi

	rbot_conf spell.program "${spell_program}"

	if use !figlet && use !toilet; then
		disable_rbot_plugin figlet
	fi

	use_rbot_conf_path figlet figlet.path /usr/bin/figlet
	use_rbot_conf_path toilet toilet.path /usr/bin/toilet

	use_rbot_plugin timezone time
	use_rbot_plugin translator translator
	use_rbot_plugin shorturl shortenurls
	use_rbot_plugin dict dictclient

	use_rbot_plugin fortune fortune
	use_rbot_conf_path fortune fortune.path /usr/bin/fortune

	use_rbot_plugin cal cal
	use_rbot_conf_path cal cal.path /usr/bin/cal

	use_rbot_plugin host host
	use_rbot_conf_path host host.path /usr/bin/host

	local rbot_datadir="${D}"/usr/share/rbot

	ruby_econf || die "ruby_econf failed"
}

src_install() {
	${RUBY} setup.rb install --prefix="${D}" \
		|| die "setup.rb install failed"

	diropts -o rbot -g nobody -m 0700
	keepdir /var/lib/rbot

	insinto /etc
	doins "${T}"/rbot.conf

	newinitd "${FILESDIR}/rbot.init" rbot
	newconfd "${FILESDIR}/rbot.conf" rbot
}

pkg_postinst() {
	einfo
	elog "rbot now can be started as a normal service."
	elog "Check /etc/conf.d/rbot file for more information about this feature."
	einfo
}
