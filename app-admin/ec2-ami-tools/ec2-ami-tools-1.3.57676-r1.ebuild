# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ec2-ami-tools/ec2-ami-tools-1.3.57676-r1.ebuild,v 1.2 2010/11/18 16:10:04 flameeyes Exp $

EAPI=2

inherit versionator

EC2_VERSION=$(get_version_component_range 1-2)
EC2_PATCHLEVEL=$(get_version_component_range 3)

DESCRIPTION="These command-line tools serve as the client interface to the Amazon EC2 web service."
HOMEPAGE="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88"
SRC_URI="http://s3.amazonaws.com/ec2-downloads/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}.zip"

S=${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}

LICENSE="Amazon"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="dev-lang/ruby:1.8[ssl]
	net-misc/rsync
	net-misc/curl"

src_prepare() {
	find . -name '*.cmd' -delete || die

	# simplify the scripts to always run ruby18, since that seems to
	# be what upstream has been using, and we support alternative
	# implementations as well.
	sed -i -e '$s:^ruby:exec ruby18:' bin/* || die
}

src_install() {
	insinto /opt/${PN}
	doins -r lib bin etc || die

	chmod 0755 "${D}/opt/${PN}/bin/"*

	dodir /etc/env.d
	cat - > "${T}"/99${PN} <<EOF
EC2_AMITOOL_HOME=/opt/${PN}
PATH=/opt/${PN}/bin
ROOTPATH=/opt/${PN}/bin
EOF
	doenvd "${T}"/99${PN}
}

pkg_postinst() {
	ewarn "Remember to run: env-update && source /etc/profile if you plan"
	ewarn "to use these tools in a shell before logging out (or restarting"
	ewarn "your login manager)"
}
