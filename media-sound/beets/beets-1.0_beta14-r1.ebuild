# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beets/beets-1.0_beta14-r1.ebuild,v 1.2 2012/05/29 17:19:16 jdhore Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils python

MY_PV=${PV/_beta/b}
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="A media library management system for obsessive-compulsive music geeks."
SRC_URI="http://beets.googlecode.com/files/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://beets.radbox.org/"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE="chroma lastgenre bpd replaygain web"

DEPEND="dev-lang/python[sqlite]
		dev-python/munkres
		dev-python/python-musicbrainz-ngs
		dev-python/unidecode
		media-libs/mutagen
		chroma? ( dev-python/pyacoustid )
		lastgenre? ( dev-python/pylast )
		bpd? ( dev-python/bluelet )
		replaygain? ( media-sound/rgain )
		web? ( dev-python/flask )"

RDEPEND="${DEPEND}"

src_prepare() {
	python_src_prepare

	# remove plugins that do not have appropriate dependencies installed
	for flag in lastgenre bpd web;do
		if ! use $flag ; then
			rm -r beetsplug/$flag* || \
				die "Unable to remove $flag plugin"
			sed -i "s:'beetsplug.$flag',::" setup.py || \
				die "Unable to disable $flag plugin "
		fi
	done

	for flag in chroma replaygain;do
		if ! use $flag ; then
			rm beetsplug/$flag.py || die "Unable to remove $flag plugin"
		fi
	done
}
