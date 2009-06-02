# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ec2-ami-tools/ec2-ami-tools-1.3.34544.ebuild,v 1.1 2009/06/02 22:24:32 caleb Exp $

inherit versionator

EC2_VERSION=$(get_version_component_range 1-2)
EC2_PATCHLEVEL=$(get_version_component_range 3)

DESCRIPTION="These command-line tools serve as the client interface to the Amazon EC2 web service."
HOMEPAGE="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88"
SRC_URI="http://s3.amazonaws.com/ec2-downloads/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}.zip"

S=${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}

LICENSE="Amazon"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="dev-lang/ruby
	net-misc/rsync
	net-misc/curl"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}"
	find . -name *.cmd -exec rm {} \;
}

src_install() {
	dodir /opt/${P}
	insinto /opt/${P}/lib
	doins -r "${S}"/lib/*
	exeinto /opt/${P}/bin
	doexe "${S}"/bin/*
	insinto /usr/bin
	for exe in "${S}"/bin/*; do
		target="$(basename ${exe})"
		base="$(basename ${exe})"
		ln -s /opt/${P}/bin/${target} "${D}"/usr/bin/${base}
	done

	insinto /opt/${P}/etc
	doins -r "${S}"/etc/*

	dodir /etc/env.d
	echo "EC2_AMITOOL_HOME=/opt/${P}" > ${D}/etc/env.d/99ec2-ami-tools
}

pkg_postinst() {
	ewarn "Remember to run: env-update && source /etc/profile if you plan"
	ewarn "to use these tools in a shell before logging out (or restarting"
	ewarn "your login manager)"
}
