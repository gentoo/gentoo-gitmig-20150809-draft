# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-2.0.5.ebuild,v 1.6 2011/06/02 17:56:29 vostorga Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
inherit waf-utils python

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="compat python"

RDEPEND="!!<sys-libs/talloc-2.0.5"
DEPEND="dev-libs/libxslt
	|| ( dev-lang/python:2.7[threads] dev-lang/python:2.6[threads] )"

WAF_BINARY="${S}/buildtools/bin/waf"

pkg_setup() {
	# Make sure the build system will use the right python
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local extra_opts=""

	use compat && extra_opts+=" --enable-talloc-compat1"
	use python || extra_opts+=" --disable-python"
	waf-utils_src_configure \
		${extra_opts}
}
