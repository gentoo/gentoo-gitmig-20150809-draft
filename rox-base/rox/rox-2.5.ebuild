# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox/rox-2.5.ebuild,v 1.2 2006/10/23 14:27:45 lack Exp $

inherit eutils

MY_P="rox-filer-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ROX is a desktop environment and filer based on RISC OS."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${MY_P}.tar.bz2"

# mark all as testing
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.14
	>=dev-util/pkgconfig-0.20
	svg? ( gnome-base/librsvg )"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.14
	svg? ( gnome-base/librsvg )"

IUSE="svg"
ROXAPPDIR="/usr/lib/rox"
MIMEDIR="/usr/share/mime"
MIMECONFDIR="/etc/xdg/rox.sourceforge.net"

src_compile() {

	cd ROX-Filer

	# Most rox self-compiles have a 'read' call to wait for the user to
	# press return if the compile fails.
	# Find and remove this:
	sed -i.bak -e 's/\<read WAIT\>/#read/' AppRun

	./AppRun --compile || die "make failed"
	(cd src; make clean) > /dev/null
	# don't need this directory anymore
	rm -fr build

	# Restore the original AppRun
	mv AppRun.bak AppRun
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
	# these are shell scripts and must be +x.
	exeinto ${MIMECONFDIR}/MIME-types
	doexe Choices/MIME-types/*
}

pkg_postinst() {
	update-mime-database ${MIMEDIR}
	einfo "${P} has been installed in ${ROXAPPDIR}."
	einfo "To run, you may type rox at a prompt (within a WM) or"
	einfo "add it to an .xinit or other script during WM startup."
}
