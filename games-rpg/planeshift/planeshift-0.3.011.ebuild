# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/planeshift/planeshift-0.3.011.ebuild,v 1.4 2007/01/05 05:00:58 flameeyes Exp $

inherit eutils games

DESCRIPTION="Virtual fantasy world MMORPG"
HOMEPAGE="http://www.planeshift.it/"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.bz2"

LICENSE="|| ( GPL-2 Planeshift )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="debug"

RDEPEND="net-misc/curl
	=dev-games/crystalspace-0.99_pre*
	=dev-games/cel-0.99_pre*"

S=${WORKDIR}/${PN}

#PLANESHIFT_PREFIX=${PLANESHIFT_PREFIX:-${GAMES_PREFIX_OPT}/${PN}}
#CRYSTAL_PREFIX=${CRYSTAL_PREFIX:-${GAMES_PREFIX_OPT}/crystal}
#CEL_PREFIX=${CEL_PREFIX:-${CRYSTAL_PREFIX}/cel}

PLANESHIFT_PREFIX=/opt/planeshift
CRYSTAL_PREFIX=/opt/crystal

src_compile() {
	./autogen.sh

	use debug && my_conf="${my_conf} --enable-debug"

	env \
		CEL=${CRYSTAL_PREFIX} \
		CRYSTAL=${CRYSTAL_PREFIX} \
		CFLAGS="${CFLAGS} -I${CRYSTAL_PREFIX}/include/cel -fPIC" \
		./configure \
			--prefix=${PLANESHIFT_PREFIX} \
			--with-cs-prefix=${CRYSTAL_PREFIX} \
			${my_conf} \
			|| die

	# Clear out the npcclient stuff.. it fails to build properly
	sed 's/SubInclude TOP src npcclient ;//' -i src/Jamfile

	jam || die
}

src_install() {
	dodir ${PLANESHIFT_PREFIX}

	mv *.{xml,cfg} "${D}/${PLANESHIFT_PREFIX}/"
	mv data docs art "${D}/${PLANESHIFT_PREFIX}/"

	jam -sprefix="${D}${PLANESHIFT_PREFIX}" install

	mv ${D}/${PLANESHIFT_PREFIX}/lib/Planeshift/* "${D}/${PLANESHIFT_PREFIX}/"
	mv ${D}/${PLANESHIFT_PREFIX}/bin/* "${D}/${PLANESHIFT_PREFIX}/"

	rmdir "${D}/${PLANESHIFT_PREFIX}/lib/Planeshift"
	rmdir "${D}/${PLANESHIFT_PREFIX}/lib"
	rmdir "${D}/${PLANESHIFT_PREFIX}/bin"

	dogamesbin ${FILESDIR}/planeshift
	dogamesbin ${FILESDIR}/planeshift-updater
	dogamesbin ${FILESDIR}/planeshift-setup
	prepgamesdirs

	chgrp -R games "${D}/${PLANESHIFT_PREFIX}"
	chmod -R g+rw "${D}/${PLANESHIFT_PREFIX}"

	# Make sure new files stay in games group
	find "${D}/${PLANESHIFT_PREFIX}" -type d -exec chmod g+sx {} \;
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "Before you can use Planeshift, you will need to update"
	ewarn "all of the art files. This can be done by typing:"
	ewarn
	ewarn "planeshift-updater -auto"
	ewarn

	einfo "Configure your client by running 'planeshift-setup'"
	einfo
	einfo "Type 'planeshift' to start the Planeshift client"
	einfo "Keep in mind, you will need to be in the games group"
}
