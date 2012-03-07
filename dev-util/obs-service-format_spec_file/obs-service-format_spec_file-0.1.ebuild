# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-format_spec_file/obs-service-format_spec_file-0.1.ebuild,v 1.2 2012/03/07 14:52:33 miska Exp $

EAPI=4

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	OPENSUSE_RELEASE="12.1"
fi

ADDITIONAL_FILES="prepare_spec"
inherit obs-service

IUSE=""

DEPEND=""
RDEPEND="${DEPEND} dev-util/suse-build"
