# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox/rox-2.3.ebuild,v 1.3 2006/10/23 14:27:45 lack Exp $

inherit eutils

# this patch includes important interim fixes from cvs
ROX_PATCH_FN="01_all_rox-cvs-fix.patch"
DESCRIPTION="ROX is a desktop environment and filer based on RISC OS."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz mirror://gentoo/${ROX_PATCH_FN}.bz2"

# mark all as testing
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.14
	>=dev-util/pkgconfig-0.20
	svg? ( gnome-base/librsvg )"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.14
	svg? ( gnome-base/librsvg )"

IUSE="svg"
ROXAPPDIR="/usr/lib/rox"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${ROX_PATCH_FN}

	# force autoconf to run again
	rm -f ${WORKDIR}/${P}/ROX-Filer/src/configure

	# guess we don't this any more
	# epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	# If the env variable PLATFORM is set, rox will build using that
	# string.  This causes issues as while the package will compile fine,
	# it will try to rebuild it the first time rox is run because it will
	# not be able to find a proper executable to run.
	use sparc && unset PLATFORM

	cd ${WORKDIR}/${P}/ROX-Filer

	# Most rox self-compiles have a 'read' call to wait for the user to
	# press return if the compile fails.
	# Find and remove this:
	sed -i.bak -e 's/\<read WAIT\>/#read/' AppRun

	./AppRun --compile || die "make failed"
	(cd src; make clean) > /dev/null

	# Restore the original AppRun
	mv AppRun.bak AppRun
}

src_install() {
	doman rox.1

	dodir ${ROXAPPDIR}
	cp -rf ROX-Filer/ ${D}/${ROXAPPDIR}

	dodir /usr/bin

	cat > "${D}/usr/bin/rox" << EOF
#!/bin/sh
exec ${ROXAPPDIR}/ROX-Filer/AppRun "\$@"
EOF

	chmod a+x ${D}/usr/bin/rox

	insinto /usr/share/mime/packages
	doins rox.xml

	dodir /usr/share/
	cp -rf Choices ${D}/usr/share/
	dodir /usr/share/Choices/Mime-icons
	keepdir /usr/share/Choices/Mime-icons

	dodir /usr/share/icons
	dosym ${ROXAPPDIR}/ROX-Filer/ROX /usr/share/icons/ROX
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}
