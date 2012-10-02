# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-format_spec_file/obs-service-format_spec_file-9999.ebuild,v 1.4 2012/10/02 11:06:11 scarabeus Exp $

EAPI=4

ADDITIONAL_FILES="prepare_spec"
inherit obs-service

IUSE=""
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/suse-build
"
