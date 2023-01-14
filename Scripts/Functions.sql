select 
				exists(select it.TiposConservacao_idTiposConservacao from EncomendaItem as ei 
				 inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
				 where ei.Encomenda_idEncomenda = new.idEncomenda and
				 it.TiposConservacao_idTiposConservacao not in 
					(select vt.TiposConservacao_idTiposConservacao from VeiculoTipo as vt 
					 where vt.Veiculo_idVeiculo = Veiculo))