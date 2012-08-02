# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/replicatorg/replicatorg-37.ebuild,v 1.1 2012/08/02 12:55:44 mattm Exp $

EAPI="3"

inherit eutils versionator

MY_P="${PN}-00${PV}"

DESCRIPTION="ReplicatorG is a simple, open source 3D printing program"
HOMEPAGE="http://replicat.org/start"
SRC_URI="http://replicatorg.googlecode.com/files/${MY_P}-linux.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""

IUSE=""

COMMON_DEPEND="dev-java/sun-jre-bin"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup replicator
}

pkg_postinst() {
	elog "Replicatorg requires Sun/Oracle JRE and will not work with OpenJDK."
	elog
	elog "Ensure that your user account has permissions to access serial port,"
	elog "if you plan to connect directly to a 3d printer.  Saving gcode"
	elog "to a flash card is currently the preferred printing method."
	elog
	elog "Note that replicatorg includes its own version of skeinforge."
	elog "There doesn't seem to be a simple way to depend on an external"
	elog "version."
	elog
	elog "Replicatorg users should add themselves to the replicator group"
	elog "to avoid upstream warnings about not being able to modify shared"
	elog "skeinforge scripts."
	elog
	chmod 0775 "${ROOT}"/opt/replicatorg
	chown root:replicator "${ROOT}"/opt/replicatorg
}

src_install() {
	dodir \
		/opt/replicatorg \
		/usr/share/replicatorg

	keepdir \
		/opt/relicatorg \
		/usr/share/replicatorg

	dobin "${FILESDIR}"/replicatorg

	/bin/cp -R --preserve=mode \
		docs \
		examples \
		lib \
		lib-i686 \
		lib-x86_64 \
		machines \
		scripts \
		replicatorg \
		skein_engines \
		tools \
		"${D}"/opt/replicatorg/

	fowners -R root:replicator /opt/replicatorg

	insinto /usr/share/replicatorg
	doins -r \
   		contributors.txt \
		license.txt \
		readme.txt \
		todo.txt

}
