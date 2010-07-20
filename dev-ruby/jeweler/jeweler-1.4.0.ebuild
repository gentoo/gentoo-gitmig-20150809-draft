# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jeweler/jeweler-1.4.0.ebuild,v 1.2 2010/07/20 07:37:41 fauli Exp $

EAPI=2
USE_RUBY="ruby18"

# Documentation is built with the yardoc task but this requires many
# dependencies which we don't have yet.
RUBY_FAKEGEM_TASK_DOC=""

# Tests and features also need the same set of dependencies present.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="ChangeLog.markdown README.markdown"

inherit ruby-fakegem

DESCRIPTION="Rake tasks for managing gems and versioning and a generator for creating a new project"
HOMEPAGE="http://wiki.github.com/technicalpickles/jeweler"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/rubyforge dev-ruby/gemcutter"
