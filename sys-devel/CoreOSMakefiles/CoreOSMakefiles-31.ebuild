# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE="http://opensource.apple.com"
SRC_URI="http://opensource.apple.com/tarballs/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/portage/licenses
	doins APPLE_LICENSE

	insinto /usr/share/${PN}/CoreOS
	doins Makefile

	for DIR in ProjectBuilder ReleaseControl ReleaseControl/mtree Standard
	do
		pushd ${DIR}
		insinto /usr/share/${PN}/CoreOS/${DIR}
		doins *
		popd
	done

}
