# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-9999.ebuild,v 1.3 2011/01/13 22:31:58 cardoe Exp $

#BACKPORTS=1

EAPI=2

if [[ ${PV} = *9999* ]]; then
	EHG_REPO_URI="http://hg.fedorahosted.org/hg/python-virtinst"
	HG_ECLASS="mercurial autotools"
fi

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils ${HG_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz
		${BACKPORTS:+mirror://gentoo/${P}-backports-${BACKPORTS}.tar.bz2}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.7.0[python]
	dev-python/urlgrabber"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="virtconv virtinst"

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
		epatch

	distutils_src_prepare
}
