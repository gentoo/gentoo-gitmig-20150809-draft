# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/pytagsfs/pytagsfs-0.9.2.ebuild,v 1.2 2010/04/14 00:28:50 sping Exp $

EAPI="2"
NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="File system that arranges media files based their tags"
HOMEPAGE="http://www.pytagsfs.org/"
SRC_URI="http://www.alittletooquiet.net/media/release/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=dev-python/fuse-python-0.2-r1
	>=dev-python/sclapp-0.5.2
	|| ( dev-python/inotifyx
		( dev-libs/libgamin[python]
			app-admin/gam-server ) )
	media-libs/mutagen"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	test? ( dev-python/inotifyx
		dev-libs/libgamin[python]
		app-admin/gam-server
		media-sound/madplay
		media-sound/vorbis-tools
		media-libs/flac )"
RESTRICT_PYTHON_ABIS="2.4 3.*"

src_test() {
	testing() {
		PYTHONPATH="build/lib" "$(PYTHON)" setup.py test
	}
	python_execute_function -s testing
}
