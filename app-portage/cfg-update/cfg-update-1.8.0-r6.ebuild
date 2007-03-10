# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/cfg-update/cfg-update-1.8.0-r6.ebuild,v 1.6 2007/03/10 15:30:10 nixnut Exp $

DESCRIPTION="Easy to use GUI & CLI alternative for etc-update with safe automatic updating functionality"
HOMEPAGE="http://people.zeelandnet.nl/xentric/"
SRC_URI="http://people.zeelandnet.nl/xentric/${PF}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="kde gnome"
KEYWORDS="amd64 ppc x86"
RDEPEND="kde? ( >=x11-misc/sux-1.0
		x11-apps/xhost
		>=dev-util/xxdiff-2.9 )
	gnome? ( >=x11-misc/sux-1.0
		x11-apps/xhost
		>=dev-util/meld-0.9 )"

S=${WORKDIR}/${PF}

pkg_postrm() {
	ewarn
	ewarn "If you want to permanently remove cfg-update from your system"
	ewarn "you should manually remove the alias for emerge from /root/.bashrc"
	ewarn "followed by running: unalias emerge"
	ewarn "and remove the index file /var/lib/cfg-update/checksum.index"
	ewarn
	ewarn "If you are just updating to a newer version you should read the"
	ewarn "installation instructions on http://people.zeelandnet.nl/xentric"
	ewarn
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cat >>cfg-update.conf <<-EOF

		INDEXFILE = /var/lib/cfg-update/checksum.index
	EOF
}

src_install() {
	exeinto /usr/bin
	doexe cfg-update emerge_with_indexing_for_cfg-update emerge_with_indexing_for_cfg-update_phphelper cfg-update_phphelper emerge_with_indexing_for_cfg-update_bashhelper
	insinto /usr/lib/cfg-update
	doins cfg-update .bashrc
	dodoc ChangeLog
	doman *.8
	insinto /etc
	doins cfg-update.conf
	keepdir /var/lib/cfg-update
}

pkg_postinst() {
	if [[ ! -e "${ROOT}"/var/lib/cfg-update/checksum.index \
		&& -e "${ROOT}"/var/lib/cfg-update/checksum.index ]]
	then
		ebegin "Moving checksum.index from /usr/lib/cfg-update to /var/lib/cfg-update"
		mv "${ROOT}"/usr/lib/cfg-update/checksum.index \
			"${ROOT}"/var/lib/cfg-update/checksum.index
		eend $?
	fi

	if [[ ${ROOT} = / ]]
	then
		ebegin "Converting old backups to new filename format"
		cfg-update --convert-old-backups &>/dev/null
		eend $?
		ebegin "Trying to remove old emerge alias from /etc/profile"
		cfg-update --remove-old-alias &>/dev/null
		eend $?
		ewarn "Please read the installation instructions on http://people.zeelandnet.nl/xentric"
		ewarn "You need to run cfg-update --on after installation!"
	fi
}
