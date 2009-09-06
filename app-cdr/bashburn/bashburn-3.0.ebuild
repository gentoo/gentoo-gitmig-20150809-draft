# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bashburn/bashburn-3.0.ebuild,v 1.2 2009/09/06 17:47:26 ssuominen Exp $

EAPI=2
MY_P=BashBurn-${PV}

DESCRIPTION="cd burning shell script"
HOMEPAGE="http://bashburn.sourceforge.net"
SRC_URI="http://bashburn.dose.se/index.php?s=file_download&id=3
			-> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dvdr"

RDEPEND="virtual/cdrtools
	app-cdr/cdrdao
	dvdr? ( app-cdr/dvd+rw-tools )
	media-sound/mpg123
	media-sound/lame
	media-sound/vorbis-tools
	media-sound/normalize
	media-libs/flac
	virtual/eject
	app-shells/bash"

S="${WORKDIR}"/${PV}

src_install() {
	sed -i "s%@@BBROOTDIR@@%/opt/BashBurn%" BashBurn.sh \
		|| die "sed failed"

	dodir /opt/BashBurn
	dodir /usr/bin

	mv {burning,config,convert,func,menus,misc,lang} "${D}"/opt/BashBurn

	exeinto /opt/BashBurn
	doexe BashBurn.sh || die

	ln -sf /opt/BashBurn/BashBurn.sh "${D}"/usr/bin/bashburn

	pushd docs
	dodoc ChangeLog CREDITS FAQ HOWTO INSTALL README TODO TRANSLATION_RULE
	popd

	pushd bashburn_man
	make bashburn.1
	doman bashburn.1
	popd
}

pkg_postinst() {
	einfo "BashBurn-3.0 now stores its settings exclusively in ~/.bashburnrc"
	einfo "Any old settings in /etc/bashburn/bashburnrc will be ignored"
}
