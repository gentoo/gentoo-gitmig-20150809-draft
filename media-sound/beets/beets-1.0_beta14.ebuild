# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beets/beets-1.0_beta14.ebuild,v 1.1 2012/05/28 11:13:42 sochotnicky Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils python

S="${WORKDIR}/${PN}-1.0b14"

DESCRIPTION="A media library management system for obsessive-compulsive music geeks."
SRC_URI="http://beets.googlecode.com/files/${PN}-1.0b14.tar.gz"
HOMEPAGE="http://beets.radbox.org/"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-python/munkres
		dev-python/python-musicbrainz-ngs
		dev-python/unidecode
		media-libs/mutagen"

RDEPEND="${DEPEND}"
