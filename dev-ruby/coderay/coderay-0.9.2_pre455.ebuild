# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coderay/coderay-0.9.2_pre455.ebuild,v 1.1 2010/02/19 10:32:59 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

if [ ${PV/_pre} != ${PV} ]; then
	# Instead of the standard X.Y.Z.preT form, coderay is released as
	# X.Y.Z.T.pre… since we need something sane for our versioning, we
	# have to play with it around… sigh!
	inherit versionator

	prever=$(get_version_component_range 4)
	RUBY_FAKEGEM_VERSION="$(get_version_component_range 1-3).${prever#pre}.pre"
fi

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="lib/README"

inherit ruby-fakegem

DESCRIPTION="A Ruby library for syntax highlighting."
HOMEPAGE="http://coderay.rubychan.de/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

all_ruby_prepare() {
	# By default coderay seems to bundle an unused copy of
	# term-ansicolor; we remove it so that we don't clutter with
	# bundled libraries, but we don't depend on it since it's
	# otherwise unused.
	rm -r lib/term || die
}
