# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox/rox-2.4.1.ebuild,v 1.2 2006/04/16 15:25:25 swegener Exp $

inherit eutils

DESCRIPTION="ROX is a desktop environment and filer based on RISC OS."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

# mark all as testing
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.14
	svg? ( gnome-base/librsvg )"

IUSE="svg"
ROXAPPDIR="/usr/lib/rox"
MIMEDIR="/usr/share/mime"
MIMECONFDIR="/etc/xdg/rox.sourceforge.net"

src_compile() {

	# *** why is this here? ***
	# *** configure does not look for it ***
	# use sparc && unset PLATFORM

	cd ROX-Filer
	./AppRun --compile || die "make failed"
	(cd src; make clean) > /dev/null
	# don't need this directory anymore
	rm -fr build
}

# new streamlined install

src_install() {
	doman rox.1

	dodir ${ROXAPPDIR}
	cp -r ROX-Filer/ ${D}/${ROXAPPDIR}

	# add documentation to be proper
	( cd ROX-Filer/Help
	dodoc Changes COPYING README README-es TODO
	)

	# install shell script
	dodir /usr/bin

	cat > "${D}/usr/bin/rox" << EOF
#!/bin/sh
exec ${ROXAPPDIR}/ROX-Filer/AppRun "\$@"
EOF

	chmod 0755 ${D}/usr/bin/rox

	# install rox.xml
	insinto ${MIMEDIR}/packages
	doins rox.xml

	# CHOICES system is gone. Now use XDG only
	insinto ${MIMECONFDIR}/MIME-types
	doins Choices/MIME-types/*
}

pkg_postinst() {
	update-mime-database ${MIMEDIR}
	einfo "${P} has been installed in ${ROXAPPDIR}."
	einfo "To run, you may type rox at a prompt (within a WM) or"
	einfo "add it to an .xinit or other script during WM startup."
}

