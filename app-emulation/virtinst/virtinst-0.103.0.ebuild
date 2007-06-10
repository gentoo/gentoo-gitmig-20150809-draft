# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-0.103.0.ebuild,v 1.1 2007/06/10 06:07:02 dberkholz Exp $

inherit distutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="3.fc7"

MY_P="python-${P}"

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
#SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz"
SRC_URI="mirror://fedora/development/source/SRPMS/${MY_P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.2.1
	dev-python/urlgrabber"
DEPEND="${RDEPEND}"

src_unpack() {
	rpm_src_unpack

	cd "${S}"
	epatch "${FILESDIR}"/${P}-accelerate.patch
	epatch "${FILESDIR}"/${P}-default-net.patch
	epatch "${FILESDIR}"/${P}-features-xml.patch
	epatch "${FILESDIR}"/${P}-rhel5-client.patch
	epatch "${FILESDIR}"/${P}-urlgrabber-import.patch
}
